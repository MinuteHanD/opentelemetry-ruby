# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require 'test_helper'

describe OpenTelemetry::Propagator::CarrierEnv::EnvGetter do
  let(:getter) { OpenTelemetry::Propagator::CarrierEnv::EnvGetter.new }

  it 'reads normalized keys' do
    _(getter.get({ 'TRACEPARENT' => 'value' }, 'traceparent')).must_equal 'value'
  end

  it 'returns nil for missing keys' do
    _(getter.get({}, 'traceparent')).must_be_nil
  end

  it 'ignores non-normalized keys' do
    _(getter.get({ 'traceparent' => 'value' }, 'traceparent')).must_be_nil
  end

  it 'lists only normalized keys' do
    carrier = { 'TRACEPARENT' => 'a', 'invalid-key' => 'b' }
    _(getter.keys(carrier)).must_equal ['TRACEPARENT']
  end
end
