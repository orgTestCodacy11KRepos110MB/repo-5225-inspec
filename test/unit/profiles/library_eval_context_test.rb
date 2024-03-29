require "helper"
require "inspec/library_eval_context"
require "inspec/resources/ini"

describe Inspec::LibraryEvalContext do
  let(:resource_content) do
    <<~EOF
      class MyTestResource < Inspec.resource(1)
        name 'my_test_resource'

        desc 'A test description'
        example 'Forgot to write docs, sorry'

        def version
          '2.0'
        end
      end
    EOF
  end

  let(:resource_content2) do
    <<~EOF
      class AnotherResource < IniConfig
        name 'another_resource'
        desc 'Another Resource description'
        example 'see README'
        def version
          '2.0'
        end
      end
    EOF
  end

  let(:registry) { Inspec::Resource.new_registry }
  let(:eval_context) { Inspec::LibraryEvalContext.create(registry, nil) }

  it "accepts a registry" do
    Inspec::LibraryEvalContext.create(registry, nil)
  end

  it "adds the resource to our registry" do
    eval_context.instance_eval(resource_content)
    _(registry.keys).must_include "my_test_resource"
  end

  it "adds nothing to the default registry" do
    _(registry.keys.sort).wont_include "my_test_resource"
    old_default_registry = Inspec::Resource.default_registry.dup
    _(old_default_registry.keys.sort).wont_include "my_test_resource"

    eval_context.instance_eval(resource_content)
    _(old_default_registry.keys.sort).must_equal Inspec::Resource.default_registry.keys.sort
    _(old_default_registry).must_equal Inspec::Resource.default_registry
  end

  it "provides an inspec context for requiring local files" do
    _(eval_context.__inspec_binding).must_be_kind_of Binding
  end

  it "adds the resource to our registry" do
    _(registry.keys).wont_include "another_resource"
    eval_context.instance_eval(resource_content2)
    old_default_registry = Inspec::Resource.default_registry.dup
    _(old_default_registry.keys.sort).must_equal Inspec::Resource.default_registry.keys.sort
  end
end
