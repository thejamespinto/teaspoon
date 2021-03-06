require "spec_helper"

feature "testing with teaspoon in the console", aruba: true do

  scenario "gives me the expected results" do
    run_simple("bundle exec teaspoon -r ../../spec/teaspoon_env.rb --suite=default app/assets/javascripts/integration/integration_spec.coffee", false)

    expected = <<-OUTPUT.strip_heredoc
    Teaspoon running default suite at http://127.0.0.1:31337/teaspoon/default
    TypeError: 'undefined' is not a function (evaluating 'foo()')
      # http://127.0.0.1:31337/relative/assets/integration/spec_helper.js:12
    OUTPUT
    output = all_output.gsub(/127\.0\.0\.1:\d+/, "127.0.0.1:31337")
    output = output.gsub("undefined is not a constructor", "'undefined' is not a function")
    assert_partial_output(expected, output)

    expected = <<-OUTPUT.strip_heredoc
    testing console output
    ..FF.*.

    Pending:
      Integration tests pending is allowed
        # Not yet implemented

    Failures:

      1) Integration tests allows failing specs
         Failure/Error: Expected true to be false.

      2) Integration tests allows erroring specs
         Failure/Error: ReferenceError: Can't find variable: foo in http://127.0.0.1:31337/relative/assets/integration/integration_spec.js?body=1 (line 14)

    Finished in 0.31337 seconds
    7 examples, 2 failures, 1 pending

    Failed examples:

    teaspoon -s default --filter="Integration tests allows failing specs."
    teaspoon -s default --filter="Integration tests allows erroring specs."
    OUTPUT
    output = all_output.gsub(/127\.0\.0\.1:\d+/, "127.0.0.1:31337")
    output = output.gsub(/Finished in [\d\.]+ seconds/, "Finished in 0.31337 seconds")
    assert_partial_output(expected, output)
  end

  describe "with coverage" do

    scenario "displays coverage information" do
      pending("needs istanbul to be installed") unless Teaspoon::Instrumentation.executable
      run_simple("bundle exec teaspoon -r ../../spec/teaspoon_env.rb --coverage=default app/assets/javascripts/integration/integration_spec.coffee", false)

      assert_partial_output("=============================== Coverage summary ===============================", all_output)
      assert_partial_output("Statements   : 95.83% ( 23/24 )", all_output)
      assert_partial_output("Branches     : 100% ( 0/0 )", all_output)
      assert_partial_output("Functions    : 92.31% ( 12/13 )", all_output)
      assert_partial_output("Lines        : 95.83% ( 23/24 )", all_output)
      assert_partial_output("================================================================================", all_output)
    end

  end

end
