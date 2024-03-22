-- キー入力を待機する関数
local function waitForKeyPress()
    local timer = os.startTimer(0.1) -- タイマーを設定しておくことで、一定間隔で他の処理を実行する

    while true do
        local event, key = os.pullEvent()
        if event == "key" then
            -- キーが押された場合の処理
            print("Key pressed:", key)
            -- ここにキーが押されたときの追加の処理を記述することができます
        elseif event == "timer" and key == timer then
            -- タイマーが発火した場合の処理
            -- 他の処理を実行する
            print("Do something else...")
            -- もう一度タイマーをセットし直す
            timer = os.startTimer(0.1)
        end
    end
end

-- キー入力を待機
waitForKeyPress()
