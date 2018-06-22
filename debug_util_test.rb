require 'json'
require 'rspec/autorun'
require_relative 'debug_util'

describe "DebugUtil" do
  context "base cases" do
    it "3 == 3" do
      expect(DebugUtil._is_object_pair_equal?(3,3)).to be_truthy
    end

    it ":foo == 'foo'" do
      expect(DebugUtil._is_object_pair_equal?(:foo, 'foo')).to be_truthy
    end

    it "'foo' == 'foo'" do
      expect(DebugUtil._is_object_pair_equal?('foo','foo')).to be_truthy
    end

    it "3 == '3'" do
      expect(DebugUtil._is_object_pair_equal?(3,'3')).to be_truthy
    end

    it "[1] == [1]" do
      expect(DebugUtil._is_object_pair_equal?([1],[1])).to be_truthy
    end

    it "[1,2] == ['1','2']" do
      expect(DebugUtil._is_object_pair_equal?([1,2],['1','2'])).to be_truthy
    end

    it "[1,2,3] != [1,2]" do
      expect(DebugUtil._is_object_pair_equal?([1,2,3],[1,2])).to be_falsey
    end

    it "[1,2] != [1,2,3,4]" do
      expect(DebugUtil._is_object_pair_equal?([1,2],[1,2,3,4])).to be_falsey
    end

    it "hash simple equals another hash" do
      expect(DebugUtil._is_object_pair_equal?({foo: 'bar'}, {foo: 'bar'})).to be_truthy
    end

    it "hash doesn't equal hash of different" do
      expect(DebugUtil._is_object_pair_equal?({}, {a: nil})).to be_falsey
      expect(DebugUtil._is_object_pair_equal?({a: nil},{})).to be_falsey
    end
  end

  context 'simple use cases' do
    it "hashes not equal another hash if simple strings are different" do
      expect(DebugUtil._is_object_pair_equal?({foo: 'bar1'}, {foo: 'bar2'})).to be_falsey
    end

    it "hashes equal if key either a string or symbol" do
      expect(DebugUtil._is_object_pair_equal?({foo: 'bar'}, {'foo' => 'bar'})).to be_truthy
    end

    it "hashes equal if symbol is either a string or symbol" do
      expect(DebugUtil._is_object_pair_equal?({foo: 'bar'}, {foo: :bar})).to be_truthy
    end

    it "hashes equal if value is the same but one is an integer and the other is a string" do
      expect(DebugUtil._is_object_pair_equal?({foo: 1}, {foo: '1'})).to be_truthy
    end

    it "hashes equal if value is a simple Array" do
      expect(DebugUtil._is_object_pair_equal?({foo: [1,2,3]}, {foo: [1,2,3]})).to be_truthy
    end

    it "hashes equal if value is a simple Array" do
      expect(DebugUtil._is_object_pair_equal?({a: [1,2,3]}, {a: [1,2,4]})).to be_falsey
    end

    it "Array of array doesn't equal array of hash" do
      expect(DebugUtil._is_object_pair_equal?([[]], [{}])).to be_falsey
      expect(DebugUtil._is_object_pair_equal?([{}], [[]])).to be_falsey
    end
  end

  context 'advanced use cases' do
    it "should be same even if hash keys are in different order" do
      expect(DebugUtil._is_object_pair_equal?({key2: 'bar', key1: 'foo'}, {key1: 'foo', key2: 'bar'})).to be_truthy
    end

    it "hash should not equal hash if value is an array with array contents not in order" do
      expect(DebugUtil._is_object_pair_equal?({foo: [1,2]}, {foo: [2,1]})).to be_falsey
    end

    it "similar hash but different should not equal" do
      expect(DebugUtil._is_object_pair_equal?({key1: 'foo', key2: 'bar'}, {key1: 'foo', key3: 'asdf', key2: 'bar'})).to be_falsey
    end

    it "similar hash but different should not equal" do
      expect(DebugUtil._is_object_pair_equal?({key1: 'foo', key2: 'bar', key3: 'asdf'}, {key1: 'foo', key2: 'bar'})).to be_falsey
    end
  end
end
