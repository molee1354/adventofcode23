import re
import sys


def parse_file(filename: str) -> int:
    sum = 0
    with open(filename, 'r') as file:
        lines = file.readlines()
        for line in lines:
            digits = re.findall(r"\d", line)
            number = int(digits[0]+digits[-1])
            sum += number
    return sum


def main() -> None:
    try:
        filename = sys.argv[1]
    except IndexError:
        print(f"No filename input. using default \"input.txt\"")
        filename = "input.txt"
        
    answer = parse_file(filename)
    print(f"Day 1 answer : {answer}")


if __name__ == "__main__":
    main()

