# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: gameOfAi.proto

require 'google/protobuf'


descriptor_data = "\n\x0egameOfAi.proto\x12\x08gameOfAi\")\n\x11GameOfLifeRequest\x12\x14\n\x0c\x66ile_content\x18\x01 \x01(\t\"B\n\x12GameOfLifeResponse\x12\x13\n\x0b\x66inal_state\x18\x01 \x03(\x05\x12\x17\n\x0fpredicted_state\x18\x02 \x03(\x05\x32V\n\nGameOfLife\x12H\n\x0bProcessFile\x12\x1b.gameOfAi.GameOfLifeRequest\x1a\x1c.gameOfAi.GameOfLifeResponseb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module GameOfAi
  GameOfLifeRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("gameOfAi.GameOfLifeRequest").msgclass
  GameOfLifeResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("gameOfAi.GameOfLifeResponse").msgclass
end
