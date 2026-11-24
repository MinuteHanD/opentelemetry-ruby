# OpenTelemetry Environment Variable Carrier

Provides environment variable getters and setters for
OpenTelemetry context propagation.

## Usage

```ruby
require 'opentelemetry-propagator-carrier-env'

getter = OpenTelemetry::Propagator::CarrierEnv::EnvGetter.new
setter = OpenTelemetry::Propagator::CarrierEnv::EnvSetter.new

carrier = {}
setter.set(carrier, 'traceparent', 'example')
getter.get(carrier, 'traceparent')
```

## Operational guidance

- Extract context during application initialization.
- Avoid modifying the parent process environment.
- Use separate environment copies for child processes.
- Do not propagate sensitive information through
  environment variables.
