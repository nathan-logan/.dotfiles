-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md

local function get_component_name(_, snip)
  local filename = snip.env.TM_FILENAME
  return string.sub(filename, 1, string.find(filename, "[.]") - 1)
end

return {
  s({
    trig = "rfc",
    name = "React Functional Component with Props",
    desc = "Inserts a React Functional Component with a props type"
  }, {
    t("type "),
    f(get_component_name),
    t("Props = "),
    t("{"),
    i(1),
    t({ "}", "\t", "export const " }),
    f(get_component_name),
    t(" = ({"),
    i(2),
    t("}: "),
    f(get_component_name),
    t({ "Props) => {", "  return " }),
    i(0),
    t({ "\t", "}" })
  }),
}
