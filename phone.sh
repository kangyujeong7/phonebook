#!/bin/bash

if [ $# -ne 4 ]; then
    echo "잘못된 입력입니다."
    exit 1
fi

name="$1"
number="$2-$3-$4"

if ! [[ "$number" =~ ^[0-9-]+$ ]]; then
    echo "$number은 숫자와 하이으로만 구성되어 있어야 합니다."
    exit 1
fi

name_in_phonebook=$(grep "$name" phonebook.txt)

if [ -n "$name_in_phonebook" ]; then
    echo "$name의 전화번호는 이미 존재합니다."
else
    echo "전화번호부에 존재하지 않는 이름입니다. 새로운 연락처를 추가합니다."

    if [ "$2" == "02" ] || [ "$2" == "053" ] || [ "$2" == "031" ] || [ "$2" == "033" ] || [ "$2" == "064" ]; then
        case $2 in
            02) area="서울" ;;
            053) area="대구" ;;
            031) area="경기" ;;
            033) area="강원" ;;
            064) area="제주" ;;
            *) echo "해당하는 지역이 없습니다." ;;
        esac

        echo "$name $number $area" >> phonebook.txt
    else
        echo "$name $number" >> phonebook.txt
    fi

    sort -o phonebook.txt phonebook.txt
fi
