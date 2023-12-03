import re
import sys

class Part2:
    def __init__(self, filename: str) -> None:
        self.filename = filename    

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

    def find_power(self, game: list[str]) -> int:
        picks = game[1::]
        iter_len = int(len(picks)/2)
        mins = {"red" : 0, "green" : 0, "blue" : 0}
        for i in range(iter_len):
            number = int(picks[2*i])
            value = picks[2*i+1]
            if number > mins[value]:
                mins[value] = number
        return mins["red"] * mins["green"] * mins["blue"]
    
    def compute(self) -> int:
        games = self.extract_gameinfo()
        sum = 0
        for game in games:
            sum += self.find_power(game)
        return sum


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


