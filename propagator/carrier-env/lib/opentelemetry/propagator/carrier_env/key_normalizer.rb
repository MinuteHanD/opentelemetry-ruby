# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

module OpenTelemetry
  module Propagator
    module CarrierEnv
      # Normalizes environment variable names.
      module KeyNormalizer
        # Converts a key into a valid environment variable name.
        # @param key [String] original key
        # @return [String] normalized key
        def self.normalize(key)
          normalized = key.tr('a-z', 'A-Z')
          normalized = normalized.gsub(/[^A-Z0-9_]/, '_')
          normalized = "_#{normalized}" if normalized.empty? || normalized.match?(/\A[0-9]/)

          normalized
        end
      end
    end
  end
end
