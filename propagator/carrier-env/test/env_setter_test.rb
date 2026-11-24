# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require 'test_helper'

describe OpenTelemetry::Propagator::CarrierEnv::EnvSetter do
  let(:setter) { OpenTelemetry::Propagator::CarrierEnv::EnvSetter.new }
  let(:carrier) { {} }

  it 'normalizes lowercase keys' do
    setter.set(carrier, 'traceparent', 'value')
    _(carrier['TRACEPARENT']).must_equal 'value'
  end

  it 'replaces hyphens with underscores' do
    setter.set(carrier, 'x-b3-traceid', 'value')
    _(carrier['X_B3_TRACEID']).must_equal 'value'
  end

  it 'handles empty keys' do
    setter.set(carrier, '', 'value')
    _(carrier['_']).must_equal 'value'
  end

  it 'prefixes keys starting with digits' do
    setter.set(carrier, '123abc', 'value')
    _(carrier['_123ABC']).must_equal 'value'
  end

  it 'replaces non-ASCII characters' do
    setter.set(carrier, 'aé中', 'value')
    _(carrier['A__']).must_equal 'value'
  end

  it 'preserves normalized keys and values' do
    setter.set(carrier, 'TRACE_PARENT', 'AbC-123')
    _(carrier['TRACE_PARENT']).must_equal 'AbC-123'
  end

  it 'replaces special characters' do
    setter.set(carrier, 'a.b/c d', 'value')
    _(carrier['A_B_C_D']).must_equal 'value'
  end

  it 'overwrites existing values' do
    setter.set(carrier, 'traceparent', 'first')
    setter.set(carrier, 'traceparent', 'second')
    _(carrier['TRACEPARENT']).must_equal 'second'
  end
end
