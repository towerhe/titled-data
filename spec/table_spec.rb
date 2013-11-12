# -*- encoding: utf-8 -*-
require 'spec_helper'

describe TitledData::Table do

  shared_examples 'titled data' do
    let(:titled_data) { TitledData::Table.new(raw_data) }

    it 'returns the titles' do
      titled_data.titles.should == %w(姓名 邮箱 手机 电话)
    end

    it 'returns the title by index' do
      titled_data.titles[0] == '姓名'
      titled_data.titles[1] == '邮箱'
      titled_data.titles[2] == '手机'
      titled_data.titles[3] == '电话'
    end

    it 'returns the raw data' do
      titled_data.raw.should == raw_data
    end

    it 'returns the data section' do
      titled_data.data.should == [
        ['张三', 'zhangsan@intimi.cn', '13811111111', '01068949999'],
        ['诸葛亮', 'zhugeliang@intimi.cn', '13911111111', '01068941111'],
        ['张三', 'zhangsan@intimi.cn', '13811111111', '01068949999']
      ]
    end

    it 'returns the specified row of data' do
      titled_data[0].data.should == %w(张三 zhangsan@intimi.cn 13811111111 01068949999)
      titled_data[1].data.should == %w(诸葛亮 zhugeliang@intimi.cn 13911111111 01068941111)

      titled_data.get(0).data.should == %w(张三 zhangsan@intimi.cn 13811111111 01068949999)
      titled_data.get(1).data.should == %w(诸葛亮 zhugeliang@intimi.cn 13911111111 01068941111)
    end

    it 'returns the value of specified cell' do
      titled_data[1][0].should == '诸葛亮'
      titled_data[1][1].should == 'zhugeliang@intimi.cn'
      titled_data[1][2].should == '13911111111'
      titled_data[1][3].should == '01068941111'

      titled_data.get(0).data.should == %w(张三 zhangsan@intimi.cn 13811111111 01068949999)
      titled_data.get(1).data.should == %w(诸葛亮 zhugeliang@intimi.cn 13911111111 01068941111)
    end

    it 'returns the value of specified cell' do
      titled_data[1][0].should == '诸葛亮'
      titled_data[1][1].should == 'zhugeliang@intimi.cn'
      titled_data[1][2].should == '13911111111'
      titled_data[1][3].should == '01068941111'
    end

    it 'returns the value by specified title' do
      titled_data.get(0, '姓名').should == '张三'
      titled_data.get(0, '邮箱').should == 'zhangsan@intimi.cn'
      titled_data.get(0, '手机').should == '13811111111'
      titled_data.get(0, '电话').should == '01068949999'
    end

    it 'returns a valid hash' do
      hsh = [{
        '姓名' => '张三', '邮箱' => 'zhangsan@intimi.cn', '手机' => '13811111111', '电话' => '01068949999'
      }, {
        '姓名' => '诸葛亮', '邮箱' => 'zhugeliang@intimi.cn', '手机' => '13911111111', '电话' => '01068941111'
      }, {
        '姓名' => '张三', '邮箱' => 'zhangsan@intimi.cn', '手机' => '13811111111', '电话' => '01068949999'
      }]

      titled_data.to_hash.should == hsh
    end

    it 'returns the names' do
      titled_data.get('姓名').should == ['张三', '诸葛亮', '张三']
    end

    it 'returns all the data with the same title' do
      data = titled_data.find_by('姓名', '张三')

      data.should have(2).items
      data.each { |d| d.get('姓名').should == '张三' }
    end

    it 'has duplicated names' do
      titled_data.should have_duplication('姓名')
    end
  end

  context 'when passing an array of data with titles' do
    let(:raw_data) {
      [
        ['姓名', '邮箱', '手机', '电话'],
        ['张三', 'zhangsan@intimi.cn', '13811111111', '01068949999'],
        ['诸葛亮', 'zhugeliang@intimi.cn', '13911111111', '01068941111'],
        ['张三', 'zhangsan@intimi.cn', '13811111111', '01068949999']
      ]
    }

    it_behaves_like 'titled data'
  end

  context 'when passing a hash array of data' do
    let(:raw_data) {
      [{
        '姓名' => '张三', '邮箱' => 'zhangsan@intimi.cn', '手机' => '13811111111', '电话' => '01068949999'
      }, {
        '姓名' => '诸葛亮', '邮箱' => 'zhugeliang@intimi.cn', '手机' => '13911111111', '电话' => '01068941111'
      }, {
        '姓名' => '张三', '邮箱' => 'zhangsan@intimi.cn', '手机' => '13811111111', '电话' => '01068949999'
      }]
    }

    it_behaves_like 'titled data'
  end
end
