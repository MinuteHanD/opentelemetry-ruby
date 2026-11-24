# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require 'test_helper'

describe 'Environment carrier integration' do
  it 'injects and extracts trace context' do
    propagator = OpenTelemetry::Trace::Propagation::TraceContext.text_map_propagator
    getter = OpenTelemetry::Propagator::CarrierEnv::EnvGetter.new
    setter = OpenTelemetry::Propagator::CarrierEnv::EnvSetter.new

    traceparent = '00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01'

    context = propagator.extract({ 'traceparent' => traceparent })

    carrier = {}
    propagator.inject(carrier, context: context, setter: setter)

    _(carrier['TRACEPARENT']).must_equal traceparent

    extracted = propagator.extract(carrier, getter: getter)
    span_context = OpenTelemetry::Trace.current_span(extracted).context

    _(span_context.hex_trace_id).must_equal '4bf92f3577b34da6a3ce929d0e0e4736'
  end
end
