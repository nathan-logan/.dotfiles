return {
  s({
    trig = "lg",
    name = "Insert debug console log",
    desc = "Inserts a console.log() with @@@ prefixed for debugging",
  }, {
    t("console.log(\"@@@"),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t("\", "),
    i(1),
    t(");")
  }),
}
