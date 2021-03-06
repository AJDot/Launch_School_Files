# String and Text Processing

## String Processing Patterns
1. Declare a new string or array to use as a container for the result.
2. Break down or parse the original string. Typically, you will break strings down by line, sentence, word, character, or by the presence of delimiters. Remove any unneeded characters from the text.
3. Depending on the shape of the problem, apply a suitable list processing strategy.
4. Combine the individual results into a new string if needed.

**Regular Expresssions** can also be used to process strings for: *search and replace*, *list building*, or *text validation*, etc.

`String` and `RegExp` objects can be used with regular expressions. `String.prototype.search`, `String.prototype.match`, and `String.prototype.replace` can be used for `String`. `RegExp.prototype.exec` and `regExp.prototype.test` can be used for `RegExp`.