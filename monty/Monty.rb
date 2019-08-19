class MontyHall
	#アクセサメソッド
	attr_accessor :doors,:result

	#コントラクタ
	def initialize(do_switch)
	    @doors          = [0,1,2].sort_by { rand }
	    @doors_content  = Array.new(3)
	    @do_switch      = do_switch

	    set_ans
	    guest_pick
	    monty_pick
	    guest_decide_to_switch_or_not(do_switch)
	    determine_outcome
	end

	#答えをセットする
	def set_ans
		@doors_content[rand(3)] =:prize
		3.times{|i| @doors_content[i] ||= :miss}
	end

	#ゲストが引く、ランダムでソートされているのでトップをポップする
	def guest_pick
		@guest_pick = @doors.pop
	end

	#モンティがハズレを見せる（ミスを選ぶ）
	def monty_pick
		door_a, door_b = @doors.sort_by { rand }

	    if @doors_content[door_a].eql?(:miss)
	      @monty_pick, @remaining_door = door_a, door_b
	    else
	      @monty_pick, @remaining_door = door_b, door_a
	    end
	end

	#交換処理
	def guest_decide_to_switch_or_not(do_switch = @do_switch)
		@guest_pick,@remaining_door  =  @remaining_door,@guest_pick  if  @do_switch
  	end

  	#正誤判定
  	def determine_outcome
  	   @result = @doors_content[@guest_pick].eql?(:prize)
  	end
end

#試行回数の定義
no_of_shows = 100_000

#任意で自分が選ぶか決められる
do_switch = false

#正解不正解のカウント
success, failure = 0, 0

#試行
no_of_shows.times { MontyHall.new(do_switch).result ? success += 1 : failure += 1 }

#出力
puts "%sを選んだ時の成功率は %.2f" % [do_switch ? "交換する" : "交換しない", ((success * 100.0)/no_of_shows)]
puts "%sを選んだ時の成功率は %.2f" % [do_switch ? "交換しない" : "交換する", ((failure * 100.0)/no_of_shows)]