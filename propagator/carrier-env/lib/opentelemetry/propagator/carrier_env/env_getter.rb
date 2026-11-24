# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

module OpenTelemetry
  module Propagator
    module CarrierEnv
      # Reads values from environment variable carriers.
      class EnvGetter
        # Reads a value using a normalized key.
        # @param carrier [Hash, ENV] environment variable carrier
        # @param key [String] key to read
        # @return [String, nil] stored value
        def get(carrier, key)
          carrier[KeyNormalizer.normalize(key)]
        end

        # Returns valid environment variable names.
        # @param carrier [Hash, ENV] environment variable carrier
        # @return [Array<String>] valid keys
        def keys(carrier)
          carrier.keys.grep(/\A[A-Z_][A-Z0-9_]*\z/)
        end
      end
    end
  end
end
