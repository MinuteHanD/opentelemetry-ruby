# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

module OpenTelemetry
  module Propagator
    module CarrierEnv
      # Writes values using normalized environment variable names.
      class EnvSetter
        # Writes a value using a normalized key.
        # @param carrier [Hash, ENV] environment variable carrier
        # @param key [String] key to normalize
        # @param value [String] value to store
        def set(carrier, key, value)
          carrier[KeyNormalizer.normalize(key)] = value
        end
      end
    end
  end
end
