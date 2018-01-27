--------------------------------lua-------------------------------------
-- 1行コメントは --以降に記述
--[[
複数行コメント
]]

-- 別ファイルの読み込みはrequireでパスを指定
local class = require 'lib/middleclass/middleclass'

-- 変数の定義時に型宣言は不要
variable = 1

-- ローカル変数の宣言時はlocal修飾子をつける
local localVar = "local"

-- printはデバッグ用に使用できる
print("abc")

-- 変数の型はtype(var)で判別できる
print(type(localVar))

-- 変数の型はnil, boolean, 数値, 文字列, テーブル, 関数, (スレッド), (ユーザーデータ)があり、動的に型付けが行われる
variable = nil
print(type(variable))
variable = false
print(type(variable))
variable = 100
print(type(variable))
variable = "bomber"
print(type(variable))

-- テーブル(配列とほぼ同義)
local tbl = { "Hello", "World", "boys", "and", "girls"}
print(type(tbl))

-- 2次元配列を作る場合
local map = {
    {0, 1, 1},
    {0, 1, 1},
    {1, 1, 0}
}

-- 任意のキーに対して値を割り当てる連想配列も定義可能
local tblB = { foo = 1, bar = 2, hoge = 3}

-- 空テーブル
local empty = {}

--- テーブルへの値の追加
empty[1] = 1;

--- テーブルの末尾に値を追加
table.insert( empty, 2 )

-- 関数定義はfunction
function backKnuckle()
    -- 文字列結合は..
    print("バック".."ナックル")
end
print(backKnuckle())

-- 数字による繰り返し構文
for i=1, 10 do
    print(i)
end

-- 関数も値として扱える
local dragonize = function(func, str)
    for i=1, 50 do
        func()
    end
    print(str.."50回でドラゴン"..str)
end
print(dragonize(backKnuckle, 'ナックル'))

-- if文 条件文では、falseとnilのみが偽の値になる
if(type(dragonize) == 'function') then
    print('ドラゴンヴァラー')
end

-- 論理演算子は not or and が使える
local bool, bool2, bool3 = false
if (not bool and (bool2 or not bool3)) then
    print('ドラゴンヴァラー2')
end

-- while文
local count = 1
while count < 10 do
    print(tostring(count))

    -- ++は使えない
    count = count + 1
end

--------------------------------middleClass-------------------------------------
-- middleClassを使ったオブジェクト指向プログラミング
-- https://github.com/kikito/middleclass

local Murabito = class('Murabito')

function Murabito:initialize(level) 
    math.randomseed(os.time())
    self.level = level
    self.HP = 4 + level * 2
    self.power = 3 + level
end

function Murabito:levelup()
    self.level = self.level + 1
    self.HP = self.HP + math.random(2, 6)
    self.power = self.power + math.random(1, 2)
end


local Senshi = class('Senshi', Murabito)

function Senshi:initialize(level) 
    Murabito.initialize(self, level)
    self.power = self.power + 1
end

function Senshi:levelup()
    self.level = self.level + 1
    self.HP = self.HP + math.random(2, 7)
    self.power = self.power + math.random(1, 3)
end

local senshi = Senshi:new(4)
print('senshi power:'..senshi.power)
senshi:levelup()
print('senshi power:'..senshi.power)
senshi:levelup()
print('senshi power:'..senshi.power)

--------------------------------love2d-------------------------------------



--プログラム起動時に最初に実行される
function love.load()
    --- 画像ファイルをアセットとして変数に格納
    blue = love.graphics.newImage("images/blue.png")

    mouseClick = 0
end

-- 毎フレーム実行される関数。画面への描画はここに実装する。
function love.draw()

    -- 配列に対するfor文
    for key, value in pairs(tbl) do
        -- 文字の描画
        love.graphics.print(value, 200 + key * 50, 300)
    end

    -- 2次元配列に対するfor文
    for mapY, mapRow in pairs(map) do 
        for mapX, mapCell in pairs(mapRow) do
            if (mapCell == 1) then
                -- 画像の描画
                love.graphics.draw(blue, 100 + mapX * 40, 200 + mapY * 40)
            end
        end
    end

    --- マウス座標の取得
    mouseX, mouseY = love.mouse.getPosition()
    --- 文字列の結合は text..textとする
    love.graphics.print('mouseX '..tostring(mouseX)..':'..'mouseY '..tostring(mouseY), 40, 40)
end

-- マウスがクリックされたときに呼ばれる関数。
function love.mousepressed(x, y, button, istouch)
    mouseClick = mouseClick + 1
    print('mouse click count:'..mouseClick)
end