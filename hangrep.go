// From standard input, filter out single chinese characters to standard output.

package main

import (
	"bufio"
	"fmt"
	"os"
	"unicode"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		text := scanner.Text()
		runes := []rune(text)
		if len(runes) != 1 {
			continue
		}
		if isHanzi(runes[0]) {
			fmt.Println(text)
		}
	}
}

func isHanzi(r rune) bool {
	return unicode.Is(unicode.Han, r)
}
