//
// Copyright (c) 2008, 2009 Boris Schaeling <boris@highscore.de>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//
#pragma once

#include <boost/noncopyable.hpp>
#include <boost/ptr_container/ptr_unordered_map.hpp>
#include <string>
#include <deque>
#include <mutex>
#include <condition_variable>
#include <windows.h>

namespace boost {
namespace asio {

class dir_monitor_impl
{
public:
    class windows_handle
        : public boost::noncopyable
    {
    public:
        windows_handle(HANDLE handle)
            : handle_(handle)
        {
        }

        ~windows_handle()
        {
            CloseHandle(handle_);
        }

    private:
        HANDLE handle_;
    };

    dir_monitor_impl()
        : run_(true)
    {
    }

    void add_directory(boost::filesystem::path dirname, HANDLE handle)
    {
        dirs_.insert(dirname, new windows_handle(handle));
    }

    void remove_directory(const boost::filesystem::path &dirname)
    {
        dirs_.erase(dirname);
    }

    void destroy()
    {
        std::unique_lock<std::mutex> lock(events_mutex_);
        run_ = false;
        events_cond_.notify_all();
    }

    dir_monitor_event popfront_event(boost::system::error_code &ec)
    {
        std::unique_lock<std::mutex> lock(events_mutex_);
        events_cond_.wait(lock, [&] { return !(run_ && events_.empty()); });

        dir_monitor_event ev;
        ec = boost::system::error_code();
        if (!run_)
            ec = boost::asio::error::operation_aborted;
        else if (!events_.empty())
        {
            ev = events_.front();
            events_.pop_front();
        }

        return ev;
    }

    void pushback_event(dir_monitor_event ev)
    {
        std::unique_lock<std::mutex> lock(events_mutex_);
        if (run_)
        {
            events_.push_back(ev);
            events_cond_.notify_all();
        }
    }

private:
    boost::ptr_unordered_map<boost::filesystem::path, windows_handle> dirs_;
    std::mutex events_mutex_;
    std::condition_variable events_cond_;
    bool run_;
    std::deque<dir_monitor_event> events_;
};

}
}

