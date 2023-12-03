import re
import sys

class Part2:
    def __init__(self, filename: str) -> None:
        self.filename = filename

    def convert(self, word: str) -> str:
        if len(word) == 1:
            return word
        conversion = {
            "one" : "1", "two" : "2", "three" : "3",
            "four" : "4", "five" : "5", "six" : "6",
            "seven" : "7", "eight" : "8", "nine" : "9",
            "zero" : "0",
        }
        return conversion[word]

    def parse_file(self) -> list[str]:
        with open(self.filename, 'r') as file:
            out = file.readlines()
        return out

    def get_digits(self) -> list[int]:
        lines = self.parse_file()
        out = []
        for line in lines:
            regex = r"(?=(\d|one|two|three|four|five|six|seven|eight|nine|zero))"
            pattern = re.compile(regex)
            numbers = [self.convert(i)
                       for i in pattern.findall(line)
                       if i != '']
            print(re.findall(pattern, line))

            out.append(int(numbers[0] + numbers[-1]))
        return out

    def compute(self) -> int:
        return sum(self.get_digits())

def main() -> None:
    try:
        filename = sys.argv[1]
    except IndexError:
        print(f"No filename input. using default \"input.txt\"")
        filename = "input.txt"
    soln = Part2(filename)
        
    answer = soln.compute()
    print(answer)


if __name__ == "__main__":
    main()

