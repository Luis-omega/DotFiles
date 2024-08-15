local set = vim.fn["SyntaxRange#Include"]
local s1 = set('->', ':', "rust")
local s2 = set('{', '}', "rust")

print(s1)
print(s2)
