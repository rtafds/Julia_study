### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ bffe9c17-3c90-4a4e-80a6-8d2a6aadf50e
using Dates

# ╔═╡ efa3cd26-3512-11ee-07ac-a7ac06d6eba6
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


# ╔═╡ 0c18a224-8208-45fc-aa74-839f52c3fa92
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

# ╔═╡ 5aa3285d-e478-4010-8f7b-99cd265591f7
text = string_sample2

# ╔═╡ 4941e36e-865b-48cc-ae8b-395549c8e728
begin
	# 数値だけ取り出す
	match_array = collect(eachmatch(r"\d+",text))
	
	num_string_array = []
	for value in match_array
		push!(num_string_array, value.match)
	end
	
end

# ╔═╡ 092188da-2167-4582-a698-14ec3839a75b
begin
	# hourは数値に直す
	hour_array = num_string_array[1:2:end]
	minute_array = num_string_array[2:2:end]
	
end

# ╔═╡ 07fa6310-6c24-4285-a9c2-bdf3f1c10290
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

# ╔═╡ f2af6870-aa76-4986-a6f7-a7440643128c
ampm_array

# ╔═╡ 12ef677b-f023-4cfa-b4df-47d37699b5b6
time_array_ = Time.(hour_array.*":".*minute_array)


# ╔═╡ dac328d2-9ed4-427c-a2ac-7c87935854ee
begin
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

# ╔═╡ 63d46bd6-00ff-45e7-8601-1249f15ff4b2
time_array

# ╔═╡ 21b65af2-cc46-46fe-87ec-4cf1d879a3b8
Time(now())-time_array[1]

# ╔═╡ 5b8e907c-8ac1-4e2f-b71d-1d417f7c40e1
begin
	work_time_start = time_array[1:2:end]
	work_time_end = time_array[2:2:end]
end
	

# ╔═╡ b7f84646-09d9-4dd7-bf77-f8db10a91408
work_time_start

# ╔═╡ c00db78f-c97f-4c57-9d42-09ad7d99e13a
work_time_end

# ╔═╡ 03ec6bfa-9891-45cf-8fd2-9ba11ca58ee4
if ! (size(work_time_start)==size(work_time_end))
	push!(work_time_end, Time(now()))
end

# ╔═╡ a57331c0-2c09-4448-b852-383fbe77462f
today_work_time = Time(sum(work_time_end .- work_time_start))

# ╔═╡ 1009a7b2-e519-4a55-8511-402e65fb06ad
Time("08:00:00") - today_work_time

# ╔═╡ c20b05dd-4314-49f8-b0a3-56972fdce1fb
if (Time("08:00:00") - today_work_time).value>0
	left_time = Time(Time("08:00:00") - today_work_time)
	sign = ""
else
	left_time = Time(today_work_time - Time("08:00:00") )
	sign= "-"
end

# ╔═╡ 032edd75-ca24-41a8-93fe-23a6552c49d5
print("今日は$(today_work_time)働きました. 8時間まであと$(sign)$(left_time)時間です。")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "d7cd76e304b32b583eb96a7ac19153dc0f2d1730"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╠═bffe9c17-3c90-4a4e-80a6-8d2a6aadf50e
# ╠═efa3cd26-3512-11ee-07ac-a7ac06d6eba6
# ╠═0c18a224-8208-45fc-aa74-839f52c3fa92
# ╠═5aa3285d-e478-4010-8f7b-99cd265591f7
# ╠═4941e36e-865b-48cc-ae8b-395549c8e728
# ╠═092188da-2167-4582-a698-14ec3839a75b
# ╠═07fa6310-6c24-4285-a9c2-bdf3f1c10290
# ╠═f2af6870-aa76-4986-a6f7-a7440643128c
# ╠═12ef677b-f023-4cfa-b4df-47d37699b5b6
# ╠═dac328d2-9ed4-427c-a2ac-7c87935854ee
# ╠═63d46bd6-00ff-45e7-8601-1249f15ff4b2
# ╠═21b65af2-cc46-46fe-87ec-4cf1d879a3b8
# ╠═5b8e907c-8ac1-4e2f-b71d-1d417f7c40e1
# ╠═b7f84646-09d9-4dd7-bf77-f8db10a91408
# ╠═c00db78f-c97f-4c57-9d42-09ad7d99e13a
# ╠═03ec6bfa-9891-45cf-8fd2-9ba11ca58ee4
# ╠═a57331c0-2c09-4448-b852-383fbe77462f
# ╠═1009a7b2-e519-4a55-8511-402e65fb06ad
# ╠═c20b05dd-4314-49f8-b0a3-56972fdce1fb
# ╠═032edd75-ca24-41a8-93fe-23a6552c49d5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
