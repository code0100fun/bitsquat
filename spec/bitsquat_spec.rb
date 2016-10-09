require 'spec_helper'

describe Bitsquat do

  it 'uses last subdomain with . repaced by n' do
    urls = Bitsquat.list('aws.amazon.com')
    expect(urls).to include('awsnamazon.com')
    urls = Bitsquat.list('something.aws.amazon.com')
    expect(urls).to include('awsnamazon.com')
  end

  it 'checks all letters in the domain name' do
    urls = Bitsquat.list('amazon.com')
    expect(urls.length).to eq(24)

    expect(urls).to include(
      # a
      'qmazon.com',
      'imazon.com',
      'emazon.com',
      'cmazon.com',
      # m
      'a-azon.com',
      'aeazon.com',
      'aiazon.com',
      'aoazon.com',
      'alazon.com',
      # a
      'amqzon.com',
      'amizon.com',
      'amezon.com',
      'amczon.com',
      # z
      'amajon.com',
      'amaron.com',
      'amaxon.com',
      # o
      'amazgn.com',
      'amazkn.com',
      'amazmn.com',
      'amaznn.com',
      # n
      'amazof.com',
      'amazoj.com',
      'amazol.com',
      'amazoo.com',
    )
  end
end
