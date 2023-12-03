import re
import sys

class Part1:
    def __init__(self, filename: str, limits: dict[str, int]) -> None:
        self.filename = filename    
        self.limits = limits

    def parse_file(self) -> list[str]:
        with open(self.filename, 'r') as file:
            out = file.readlines()
        return out

    def extract_gameinfo(self) -> list[list[str]]:
        lines = self.parse_file()
        out = []
        for line in lines:
            pattern = re.compile(r"[0-9]+|red|green|blue")
            result = pattern.findall(line)
            out.append(result)
        return out

    def is_possible(self, game: list[str]) -> int:
        id = game[0]
        picks = game[1::]
        iter_len = int(len(picks)/2)
        for i in range(iter_len):
            number = int(picks[2*i])
            value = picks[2*i+1]
            if number > self.limits[value]:
                return 0
        return int(id)
    
    def compute(self) -> int:
        games = self.extract_gameinfo()
        sum = 0
        for game in games:
            sum += self.is_possible(game)
        return sum


def main() -> None:
    try:
        filename = sys.argv[1]
    except IndexError:
        print(f"No filename input. using default \"input.txt\"")
        filename = "input.txt"
    limits = {"red" : 12, "green" : 13, "blue" : 14}
    soln = Part1(filename, limits)
        
    answer = soln.compute()
    print(answer)


if __name__ == "__main__":
    main()


