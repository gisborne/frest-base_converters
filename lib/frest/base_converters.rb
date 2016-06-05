require "frest/base_converters/version"

module Frest
  module BaseConverters
    def fn_to_html source:, to: _, form_tag: true
      params = Frest::RichFunction.params(fn: source)
      required = params.select{|type, _| type == :keyreq}.map{|_, v| v}
      (form_tag ? '<form>' : '') +
      required.map do |k|
        "#{k}: <input name=\"#{k}\">"
      end * "\n" + "<input type=\"submit\">"
    end

    module_function :fn_to_html
  end
end

Frest::Convert.register_converter(
    converter: Frest::BaseConverters.method(:fn_to_html),
    from: Proc,
    to: 'html'
)