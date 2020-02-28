/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.service;

/**
 * @Class Name : SampleVO.java
 * @Description : SampleVO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public class SampleVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	private String id;
	/** 이름 */
	private String name;
	/** 내용 */
	private String description;
	/** 사용여부 */
	private String useYn;
	/** 등록자 */
	private String regUser;
	
	private String itemId; // 종목ID 종목코드
	private String itemName; // 종목명
	private String dealDate; // 거래일
	
	private String year;	// 년
	private String month;	// 월
	private String day;		// 일
	
	private int priceOpen; // 시가
	private int priceHigh; // 고가
	private int priceLow; // 저가
	private int priceClose; // 종가
	
	
	private int volume; // 거래량
	
	private double priceAvg5; // 5일 기준
	private double priceAvg10; // 10일 기준
	private double priceAvg20; // 20일 기준
	private double priceAvg60; // 60일 기준
	private double priceAvg120; // 120일 기준
	
	private double volumeAvg5; // 거개량 이동평균 5일
	private double volumeAvg20; // 거개량 이동평균 20일
	private double volumeAvg60; // 거개량 이동평균 60일
	private double volumeAvg120; // 거개량 이동평균 120일
	
	private int compared1; // 전일대비 날짜
	private double compared2; // 전일대비 종가
	private double compared3; // 전일대비 계산 값
	private double fluctuation; // 등락률
	
	private String calender; // 일 주 월

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getRegUser() {
		return regUser;
	}

	public void setRegUser(String regUser) {
		this.regUser = regUser;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getDealDate() {
		return dealDate;
	}

	public void setDealDate(String dealDate) {
		this.dealDate = dealDate;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public int getPriceOpen() {
		return priceOpen;
	}

	public void setPriceOpen(int priceOpen) {
		this.priceOpen = priceOpen;
	}

	public int getPriceHigh() {
		return priceHigh;
	}

	public void setPriceHigh(int priceHigh) {
		this.priceHigh = priceHigh;
	}

	public int getPriceLow() {
		return priceLow;
	}

	public void setPriceLow(int priceLow) {
		this.priceLow = priceLow;
	}

	public int getPriceClose() {
		return priceClose;
	}

	public void setPriceClose(int priceClose) {
		this.priceClose = priceClose;
	}

	public int getVolume() {
		return volume;
	}

	public void setVolume(int volume) {
		this.volume = volume;
	}

	public double getPriceAvg5() {
		return priceAvg5;
	}

	public void setPriceAvg5(double priceAvg5) {
		this.priceAvg5 = priceAvg5;
	}

	public double getPriceAvg10() {
		return priceAvg10;
	}

	public void setPriceAvg10(double priceAvg10) {
		this.priceAvg10 = priceAvg10;
	}

	public double getPriceAvg20() {
		return priceAvg20;
	}

	public void setPriceAvg20(double priceAvg20) {
		this.priceAvg20 = priceAvg20;
	}

	public double getPriceAvg60() {
		return priceAvg60;
	}

	public void setPriceAvg60(double priceAvg60) {
		this.priceAvg60 = priceAvg60;
	}

	public double getPriceAvg120() {
		return priceAvg120;
	}

	public void setPriceAvg120(double priceAvg120) {
		this.priceAvg120 = priceAvg120;
	}

	public double getVolumeAvg5() {
		return volumeAvg5;
	}

	public void setVolumeAvg5(double volumeAvg5) {
		this.volumeAvg5 = volumeAvg5;
	}

	public double getVolumeAvg20() {
		return volumeAvg20;
	}

	public void setVolumeAvg20(double volumeAvg20) {
		this.volumeAvg20 = volumeAvg20;
	}

	public double getVolumeAvg60() {
		return volumeAvg60;
	}

	public void setVolumeAvg60(double volumeAvg60) {
		this.volumeAvg60 = volumeAvg60;
	}

	public double getVolumeAvg120() {
		return volumeAvg120;
	}

	public void setVolumeAvg120(double volumeAvg120) {
		this.volumeAvg120 = volumeAvg120;
	}

	public int getCompared1() {
		return compared1;
	}

	public void setCompared1(int compared1) {
		this.compared1 = compared1;
	}

	public double getCompared2() {
		return compared2;
	}

	public void setCompared2(double compared2) {
		this.compared2 = compared2;
	}

	public double getCompared3() {
		return compared3;
	}

	public void setCompared3(double compared3) {
		this.compared3 = compared3;
	}

	public double getFluctuation() {
		return fluctuation;
	}

	public void setFluctuation(double fluctuation) {
		this.fluctuation = fluctuation;
	}

	public String getCalender() {
		return calender;
	}

	public void setCalender(String calender) {
		this.calender = calender;
	}
	
	
	
	
}
