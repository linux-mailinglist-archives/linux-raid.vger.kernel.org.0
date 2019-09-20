Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D356EB9753
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 20:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404171AbfITSoN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 14:44:13 -0400
Received: from mail.prgmr.com ([71.19.149.6]:35256 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393299AbfITSoN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 14:44:13 -0400
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id E998372008B;
        Fri, 20 Sep 2019 19:39:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com E998372008B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1569022769;
        bh=JLHmI3/py42KXEhfL8ntGLkYsLUmaRmCL7I0XNn39s8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eIOFiGKzax2e+yb3fe0qQ1pnMEp6pei1XmtPdl1LVeeukhhmWwsb9OnvQPrBWUyOD
         nAg3+wbSE9DddZ2G6sjjWL9jCslVABEA3IoGfuUGIiokW9SU5LfcV6M0So6PPAw+35
         9OSGeVvYin38rMmuJM4kJUoPb9b+xBZiDoFA23MM=
Subject: Re: RAID 10 with 2 failed drives
To:     Liviu.Petcu@ugal.ro
Cc:     linux-raid@vger.kernel.org
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <23940.1755.134402.954287@quad.stoffel.home>
 <094701d56f7c$95225260$bf66f720$@ugal.ro>
 <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com>
 <5533186790ebac6af6d14bd493b9ebbe@ugal.ro>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <41b046be-0db7-3ae6-3b91-f4024753f74d@prgmr.com>
Date:   Fri, 20 Sep 2019 11:44:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5533186790ebac6af6d14bd493b9ebbe@ugal.ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/20/19 11:11 AM, Iulian Petcu wrote:
>   
> 
> În 20.09.2019 10:44, Sarah Newman a scris:
> 
>> On 9/19/19 11:28 PM, Liviu Petcu wrote:
>>
>>> Thank you John Stoffel. So far I have done nothing but mdadm - exams. Both disks seem to be gone and have no led activity. Below are the system information and the details of the event from /var/log/messages.
>>
>> Maybe try reseating the drives, or reseating cables, or put the drives in a different server? Two drives being kicked at the same time sounds like a problem other than the hard drives themselves, unless you haven't been running any sort of SMART self tests or raid checks.
> 
> Thanks for your tips, Sarah. I have already removed all the disks to
> make images on a 12 TB drive. I started with disks 1 and 2 that are in
> trouble. I think disk 1 is dead because fdisk reported multiple
> "print_req_errorL I/O, dev sdb, sector x" and "Buffer I/O error on dev
> sdb, logical bloc y, async page read". Disk 2 is different:
> 
> # smartctl --all /dev/sdb
> smartctl 6.5 2016-05-07 r4318 [i686-linux-4.8.2-pmagic] (local build)
> Copyright (C) 2002-16, Bruce Allen, Christian Franke,
> www.smartmontools.org
> 
> === START OF INFORMATION SECTION ===
> Model Family: Seagate Constellation ES.3
> Device Model: ST2000NM0033-9ZM175
> Serial Number: S1X05AW6
> LU WWN Device Id: 5 000c50 074a24a4d
> Firmware Version: SN03
> User Capacity: 2,000,398,934,016 bytes [2.00 TB]
> Sector Size: 512 bytes logical/physical
> Rotation Rate: 7200 rpm
> Form Factor: 3.5 inches
> Device is: In smartctl database [for details use: -P show]
> ATA Version is: ACS-2 (minor revision not indicated)
> SATA Version is: SATA 3.0, 6.0 Gb/s (current: 3.0 Gb/s)
> Local Time is: Fri Sep 20 21:00:27 2019 CDT
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> 
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> General SMART Values:
> Offline data collection status: (0x82) Offline data collection activity
>   was completed without error.
>   Auto Offline Data Collection: Enabled.
> Self-test execution status: ( 0) The previous self-test routine
> completed
>   without error or no self-test has ever
>   been run.
> Total time to complete Offline
> data collection: ( 584) seconds.
> Offline data collection
> capabilities: (0x7b) SMART execute Offline immediate.
>   Auto Offline data collection on/off support.
>   Suspend Offline collection upon new
>   command.
>   Offline surface scan supported.
>   Self-test supported.
>   Conveyance Self-test supported.
>   Selective Self-test supported.
> SMART capabilities: (0x0003) Saves SMART data before entering
>   power-saving mode.
>   Supports SMART auto save timer.
> Error logging capability: (0x01) Error logging supported.
>   General Purpose Logging supported.
> Short self-test routine
> recommended polling time: ( 1) minutes.
> Extended self-test routine
> recommended polling time: ( 248) minutes.
> Conveyance self-test routine
> recommended polling time: ( 2) minutes.
> SCT capabilities: (0x50bd) SCT Status supported.
>   SCT Error Recovery Control supported.
>   SCT Feature Control supported.
>   SCT Data Table supported.
> 
> SMART Attributes Data Structure revision number: 10
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME FLAG VALUE WORST THRESH TYPE UPDATED WHEN_FAILED
> RAW_VALUE
>   1 Raw_Read_Error_Rate 0x000f 082 063 044 Pre-fail Always - 192708731
>   3 Spin_Up_Time 0x0003 095 095 000 Pre-fail Always - 0
>   4 Start_Stop_Count 0x0032 100 100 020 Old_age Always - 41
>   5 Reallocated_Sector_Ct 0x0033 100 100 010 Pre-fail Always - 0
>   7 Seek_Error_Rate 0x000f 095 060 030 Pre-fail Always - 3333101297
>   9 Power_On_Hours 0x0032 053 053 000 Old_age Always - 41641
>   10 Spin_Retry_Count 0x0013 100 100 097 Pre-fail Always - 0
>   12 Power_Cycle_Count 0x0032 100 100 020 Old_age Always - 41
> 184 End-to-End_Error 0x0032 100 100 099 Old_age Always - 0
> 187 Reported_Uncorrect 0x0032 100 100 000 Old_age Always - 0
> 188 Command_Timeout 0x0032 100 100 000 Old_age Always - 0
> 189 High_Fly_Writes 0x003a 099 099 000 Old_age Always - 1
> 190 Airflow_Temperature_Cel 0x0022 058 050 045 Old_age Always - 42
> (Min/Max 24/42)
> 191 G-Sense_Error_Rate 0x0032 100 100 000 Old_age Always - 0
> 192 Power-Off_Retract_Count 0x0032 100 100 000 Old_age Always - 28
> 193 Load_Cycle_Count 0x0032 100 100 000 Old_age Always - 1786
> 194 Temperature_Celsius 0x0022 042 050 000 Old_age Always - 42 (0 19 0 0
> 0)
> 195 Hardware_ECC_Recovered 0x001a 025 003 000 Old_age Always - 192708731
> 197 Current_Pending_Sector 0x0012 100 100 000 Old_age Always - 0
> 198 Offline_Uncorrectable 0x0010 100 100 000 Old_age Offline - 0
> 199 UDMA_CRC_Error_Count 0x003e 200 200 000 Old_age Always - 0
> 
> SMART Error Log Version: 1
> No Errors Logged
> 
> SMART Self-test log structure revision number 1
> No self-tests have been logged. [To run self-tests, use: smartctl -t]
> 
> SMART Selective self-test log data structure revision number 1
>   SPAN MIN_LBA MAX_LBA CURRENT_TEST_STATUS
>   1 0 0 Not_testing
>   2 0 0 Not_testing
>   3 0 0 Not_testing
>   4 0 0 Not_testing
>   5 0 0 Not_testing
> Selective self-test flags (0x0):
>   After scanning selected spans, do NOT read-scan remainder of disk.
> If Selective self-test is pending on power-up, resume after 0 minute
> delay.
> 
> # fdisk -l /dev/sdb
> Disk /dev/sdb: 1.8 TiB, 2000398934016 bytes, 3907029168 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: gpt
> Disk identifier: A95A32BD-3198-4C9B-8445-BAC177AA5B31
> 
> Device Start End Sectors Size Type
> /dev/sdb1 2048 8388641 8386594 4G Linux RAID
> /dev/sdb2 8390656 3907029134 3898638479 1.8T Linux RAID
> 
> I think I might try to make an image with dd...

Yes, that drive looks good. You should run mdadm --examine on the raid device from that too and if the "event count" is pretty close to the rest of 
the drives, force assembling it should work. x-ref https://raid.wiki.kernel.org/index.php/RAID_Recovery#Trying_to_assemble_using_--force

Going forwards, consider running weekly long SMART tests and configuring smartd to send alerts. The package is probably named smartmontools. I think 
you also want to configure https://en.wikipedia.org/wiki/Time-Limited_Error_Recovery
