# This is a minimal set of ANSI/VT100 color codes
_END=$'\x1b[0m'
_BOLD=$'\x1b[1m'
# _UNDER=$'\x1b[4m'
# _REV=$'\x1b[7m'
#
# # Colors
# _GREY=$'\x1b[30m'
# _RED=$'\x1b[31m'
# _GREEN=$'\x1b[32m'
_YELLOW=$'\x1b[33m'
# _BLUE=$'\x1b[34m'
# _PURPLE=$'\x1b[35m'
# _CYAN=$'\x1b[36m'
# _WHITE=$'\x1b[37m'
#
# # Inverted, i.e. colored backgrounds
# _IGREY=$'\x1b[40m'
_IRED=$'\x1b[41m'
 _IGREEN=$'\x1b[42m'
# _IYELLOW=$'\x1b[43m'
_IBLUE=$'\x1b[44m'
# _IPURPLE=$'\x1b[45m'
# _ICYAN=$'\x1b[46m'
# _IWHITE=$'\x1b[47m'

build:
	@echo "${_BOLD}${_YELLOW}${_IBLUE}generating executable -> npuzzle${_END}"
	@swiftc -O Engine.swift Generator.swift Goal.swift Heuristic.swift Node.swift ParseArgs.swift ParseFile.swift PriorityQueue.swift Solvability.swift main.swift ./Algo/Algo.swift ./Algo/Astar.swift ./Algo/Greedy.swift ./Algo/SearchPath.swift -module-name npuzzle
	@echo "${_BOLD}${_YELLOW}${_IGREEN}done${_END}"

.PHONY: build
