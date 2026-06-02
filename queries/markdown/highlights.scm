;; extends

((fenced_code_block) @markup.raw.block (#set! priority 90))
(fenced_code_block (fenced_code_block_delimiter) @markup.raw.block)
(fenced_code_block (info_string (language) @label))
