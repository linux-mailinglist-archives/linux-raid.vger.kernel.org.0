Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D230D19C00E
	for <lists+linux-raid@lfdr.de>; Thu,  2 Apr 2020 13:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbgDBLUQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Apr 2020 07:20:16 -0400
Received: from atl.turmel.org ([74.117.157.138]:51719 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgDBLUQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Apr 2020 07:20:16 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jJxtO-0003w0-8B; Thu, 02 Apr 2020 07:20:14 -0400
Subject: Re: RAID Issues - RAID10 working but with errors
To:     Wolfgang Denk <wd@denx.de>,
        Adam Goryachev <mailinglists@websitemanagers.com.au>
Cc:     linux-raid@vger.kernel.org
References: <d934f662-9fde-370b-bb4b-b92bd1730c96@websitemanagers.com.au>
 <20200402091914.4330D24003E@gemini.denx.de>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <c95d82c4-1ee9-c783-48d0-1b8c3812d324@turmel.org>
Date:   Thu, 2 Apr 2020 07:20:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402091914.4330D24003E@gemini.denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/2/20 5:19 AM, Wolfgang Denk wrote:
> Dear Adam,
> 
> In message <d934f662-9fde-370b-bb4b-b92bd1730c96@websitemanagers.com.au> you wrote:
>>
>> smartctl -x /dev/sdd
> ...
>> Model Family:     Western Digital RE4
>> Device Model:     WDC WD2003FYYS-02W0B0
>> Serial Number:    WD-WMAY00922575
> ...
>> SMART Attributes Data Structure revision number: 16
>> Vendor Specific SMART Attributes with Thresholds:
>> ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
>>     1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    23
>>     3 Spin_Up_Time            POS--K   253   253   021    -    8583
>>     4 Start_Stop_Count        -O--CK   100   100   000    -    77
>>     5 Reallocated_Sector_Ct   PO--CK   184   184   140    -    126
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     7 Seek_Error_Rate         -OSR-K   200   200   000    -    0
>>     9 Power_On_Hours          -O--CK   017   017   000    -    61089
>>    10 Spin_Retry_Count        -O--CK   100   253   000    -    0
>>    11 Calibration_Retry_Count -O--CK   100   253   000    -    0
>>    12 Power_Cycle_Count       -O--CK   100   100   000    -    67
>> 192 Power-Off_Retract_Count -O--CK   200   200   000    -    48
>> 193 Load_Cycle_Count        -O--CK   200   200   000    -    28
>> 194 Temperature_Celsius     -O---K   118   105   000    -    34
>> 196 Reallocated_Event_Count -O--CK   095   095   000    -    105
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 197 Current_Pending_Sector  -O--CK   200   200   000    -    21
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 198 Offline_Uncorrectable   ----CK   200   200   000    -    0
>> 199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    0
>> 200 Multi_Zone_Error_Rate   ---R--   200   200   000    -    2
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This disk has a pretty high count of reallocated sectors, plus a lot
> of other errors.  I recommend to replace it ASAP.  It is not worth

Concur.  Old and worn out.  Personally, I replace when reallocations are 
in the 10 to 20 range.  Once you get past that, they seem to start 
coming much faster.


>> smartctl -x /dev/sdf
> ...
>> Model Family:     Western Digital RE4
>> Device Model:     WDC WD2003FYYS-02W0B0
>> Serial Number:    WD-WMAY00611922
> ...
>> ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
>>     1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    0
>>     3 Spin_Up_Time            POS--K   253   253   021    -    7350
>>     4 Start_Stop_Count        -O--CK   100   100   000    -    73
>>     5 Reallocated_Sector_Ct   PO--CK   200   200   140    -    0
>>     7 Seek_Error_Rate         -OSR-K   200   200   000    -    0
>>     9 Power_On_Hours          -O--CK   051   051   000    -    36231
>>    10 Spin_Retry_Count        -O--CK   100   253   000    -    0
>>    11 Calibration_Retry_Count -O--CK   100   253   000    -    0
>>    12 Power_Cycle_Count       -O--CK   100   100   000    -    64
>> 192 Power-Off_Retract_Count -O--CK   200   200   000    -    46
>> 193 Load_Cycle_Count        -O--CK   200   200   000    -    26
>> 194 Temperature_Celsius     -O---K   118   094   000    -    34
>> 196 Reallocated_Event_Count -O--CK   200   200   000    -    0
>> 197 Current_Pending_Sector  -O--CK   200   200   000    -    0
>> 198 Offline_Uncorrectable   ----CK   200   200   000    -    0
>> 199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    0
>> 200 Multi_Zone_Error_Rate   ---R--   200   200   000    -    2
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ...
>>     40 -- 51 0a 00 00 00 2a 25 4e 10 40 00  Error: UNC at LBA =
>> 0x2a254e10 = 707087888
> ...
>>     40 -- 51 0a 00 00 00 1e 5a 3e 86 40 00  Error: UNC at LBA =
>> 0x1e5a3e86 = 509230726
> ...
>>     40 -- 51 0a 00 00 00 1e 0c 77 d3 40 00  Error: UNC at LBA =
>> 0x1e0c77d3 = 504133587
> ...
>>     40 -- 51 0a 00 00 00 1d e4 17 e7 40 00  Error: UNC at LBA =
>> 0x1de417e7 = 501487591
> ...
>>     40 -- 51 0a 00 00 00 1d c0 73 99 40 00  Error: UNC at LBA =
>> 0x1dc07399 = 499151769
> ...
>>     40 -- 51 0a 00 00 00 1d 23 fc 01 40 00  Error: UNC at LBA =
>> 0x1d23fc01 = 488897537
> 
> This disk also has stored a number of errors, but it does not look
> as bad as the first one.  However, there are errors.  I would
> replace it as well.

Disagree.  No reallocations by the drive, just bad block log entries. 
This drive is fine.  The bad block log mis-feature should be turned off 
after failing this drive, zeroing its superblock, and adding back to the 
array (so the bad blocks get reconstructed).

The bad block log mis-feature should never have been merged in its 
current form--it simply prevents redundancy from ever working on problem 
sectors, and cannot distinguish correctable communications problems from 
true underlying uncorrectable sectors.  Which should be left to the 
drive, at least until it runs out of spare sectors.  (And why would you 
keep such a drive anyways?) Bad block logging in MD raid is *Dangerous* 
*Junk*.

> Best regards,
> 
> Wolfgang Denk

Regards,

Phil

