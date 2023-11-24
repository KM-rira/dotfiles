# 第一引数を変数に格納
arg="$1"
option=""

# case文を使用して引数に応じた処理を行う
case $arg in
    a)
        option='--state all'
        ;;
    o)
        option='--state open'
        ;;
    c)
        option='--state closed'
        ;;
    d)
        option='--draft'
        ;;
esac

echo "$option"