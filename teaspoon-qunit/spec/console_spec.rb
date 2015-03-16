require_relative "./spec_helper"

feature "Running in the console", shell: true do
  let(:expected_output) do
    <<-OUTPUT.strip_heredoc
      Starting the Teaspoon server...
      Teaspoon running default suite at http://127.0.0.1:31337/teaspoon/default
      TypeError: undefined is not a constructor (evaluating 'foo()')
        # integration/test_helper.js:12

      FFFit can log to the console
      ..

      Failures:

        1)  global failure (1, 0, 1)
           Failure/Error: TypeError: undefined is not a constructor (evaluating 'foo()')

        2) Integration tests allows failing specs (1, 0, 1)
           Failure/Error: fails correctly

        3) Integration tests allows erroring specs (1, 0, 1)
           Failure/Error: errors correctly

      Finished in 0.31337 seconds
      5 examples, 3 failures

      Failed examples:

      teaspoon -s default --filter="undefined global failure"
      teaspoon -s default --filter="Integration tests allows failing specs"
      teaspoon -s default --filter="Integration tests allows erroring specs"
    OUTPUT
  end

  before do
    teaspoon_test_app("gem 'teaspoon-qunit', path: '#{Teaspoon::DEV_PATH}'")
    install_teaspoon("--coffee")
    copy_integration_files("test", File.expand_path("../../test", __FILE__), "test")
  end

  it "runs successfully using the CLI" do
    run_teaspoon("--no-color")

    expect(teaspoon_output).to include(expected_output)
  end

  it "runs successfully using the rake task" do
    rake_teaspoon("COLOR=false")

    expect(teaspoon_output).to include(expected_output)
  end

  it "can display coverage information" do
    pending("needs istanbul to be installed") unless Teaspoon::Instrumentation.executable
    run_teaspoon("--coverage=default")

    expect(teaspoon_output).to include(<<-COVERAGE.strip_heredoc)
      =============================== Coverage summary ===============================
      Statements   : 75% ( 3/4 )
      Branches     : 100% ( 0/0 )
      Functions    : 50% ( 1/2 )
      Lines        : 75% ( 3/4 )
      ================================================================================
    COVERAGE
  end
end
