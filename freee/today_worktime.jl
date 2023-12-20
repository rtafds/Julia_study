using Dates

string_sample = 
"""freee人事労務
APP  8:29 AM
今日も一日頑張りましょう！
:white_check_mark: 出勤しました

freee人事労務
APP  9:55 AM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  10:30 AM
おかえりなさいませ
:white_check_mark: 休憩終了しました

freee人事労務
APP  12:05 PM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  12:59 PM
おかえりなさいませ
:white_check_mark: 休憩終了しました

freee人事労務
APP  2:54 PM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました"""


string_sample2 = 
"""freee人事労務
APP  8:29 AM
今日も一日頑張りましょう！
:white_check_mark: 出勤しました

freee人事労務
APP  9:55 AM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  10:30 AM
おかえりなさいませ
:white_check_mark: 休憩終了しました

freee人事労務
APP  12:05 PM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  12:59 PM
おかえりなさいませ
:white_check_mark: 休憩終了しました

freee人事労務
APP  2:54 PM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  3:16 PM
おかえりなさいませ
:white_check_mark: 休憩終了しました
"""

aaa=
"""
freee人事労務
APP  9:46 AM
今日も一日頑張りましょう！
:white_check_mark: 出勤しました

freee人事労務
APP  12:31 PM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  12:59 PM
おかえりなさいませ
:white_check_mark: 休憩終了しました

freee人事労務
APP  3:36 PM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  4:54 PM
おかえりなさいませ
:white_check_mark: 休憩終了しました

freee人事労務
APP  5:00 PM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  5:29 PM
おかえりなさいませ
:white_check_mark: 休憩終了しました
:warning: 打刻の種類が正しくありません。リロードして再度お試しください。もう一度コマンドを実行してください。何度もエラーになる場合はサポートにお問い合わせください

freee人事労務
APP  6:46 PM
お仕事お疲れ様です
:white_check_mark: 休憩開始しました

freee人事労務
APP  8:01 PM
おかえりなさいませ
:white_check_mark: 休憩終了しました
"""

function today_work_time_calc(text)

    begin
        # 数値だけ取り出す
        match_array = collect(eachmatch(r"\d+",text))
        
        num_string_array = []
        for value in match_array
            push!(num_string_array, value.match)
        end
        
    end

    begin
        # hourは数値に直す
        hour_array = num_string_array[1:2:end]
        minute_array = num_string_array[2:2:end]
        
    end

    begin
        # AMとPMの情報を取得(割と強引)
        minute_match_array = match_array[2:2:end]
        ampm_array = []
        for match in minute_match_array
            ampm_begin_offset = match.offset+3
            ampm_end_offset = ampm_begin_offset + 1 # magix number
            ampm = text[ampm_begin_offset:ampm_end_offset]
            push!(ampm_array, ampm)
        end
    end


    begin
        time_array_ = Time.(hour_array.*":".*minute_array)
        time_array = []
        for (i,time_) in enumerate(time_array_)
            if ampm_array[i]=="PM" && ! (hour_array[i]=="12")
                time = time_ + Hour(12)
            else
                time = time_
            end
            push!(time_array, time)
        end
    end


    begin
        work_time_start = time_array[1:2:end]
        work_time_end = time_array[2:2:end]
    end

    if ! (size(work_time_start)==size(work_time_end))
        push!(work_time_end, Time(now()))
    end

    # ╔═╡ a57331c0-2c09-4448-b852-383fbe77462f
    today_work_time = Time(sum(work_time_end .- work_time_start))

    Time("08:00:00") - today_work_time

    if (Time("08:00:00") - today_work_time).value>0
        left_time = Time(Time("08:00:00") - today_work_time)
        sign = ""
    else
        left_time = Time(today_work_time - Time("08:00:00") )
        sign= "-"
    end

    println("今日は$(today_work_time)働きました. 8時間まであと$(sign)$(left_time)時間です。")
end

# debug
#text = string_sample
text = aaa

today_work_time_calc(text)
