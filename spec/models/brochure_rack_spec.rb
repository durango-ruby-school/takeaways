require 'spec_helper'

describe BrochureRack do
  it{should validate_presence_of(:name)}
  it{should validate_presence_of(:number_of_rows)}
  it{should validate_presence_of(:number_of_columns)}
end
