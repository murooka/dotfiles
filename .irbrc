require 'irb/completion'
IRB.conf[:PROMPT][:HOGE] = {
    :PROMPT_I => "%03n:>> ",
    :PROMPT_N => "%03n:%i>",
    :PROMPT_S => "%03n:>%l ",
    :PROMPT_C => "%03n:>> ",
    :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :HOGE
