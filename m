Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2119BE7B
	for <lists+linux-raid@lfdr.de>; Thu,  2 Apr 2020 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbgDBJT1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Apr 2020 05:19:27 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36336 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBJT1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 Apr 2020 05:19:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48tHZM5l8Xz1qrLn
        for <linux-raid@vger.kernel.org>; Thu,  2 Apr 2020 11:19:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48tHZM5PmQz1qv4F
        for <linux-raid@vger.kernel.org>; Thu,  2 Apr 2020 11:19:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 8wQw5VSakjth for <linux-raid@vger.kernel.org>;
        Thu,  2 Apr 2020 11:19:20 +0200 (CEST)
X-Auth-Info: JH/vQtJ2e2D2Xv9Upv8eKKlGtcpoYS3hpLGid6u0HMA=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-raid@vger.kernel.org>; Thu,  2 Apr 2020 11:19:20 +0200 (CEST)
Received: by janitor.denx.de (Postfix, from userid 119)
        id 423A7A2C3F; Thu,  2 Apr 2020 11:19:20 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 19752A2C44;
        Thu,  2 Apr 2020 11:19:15 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id 4330D24003E;
        Thu,  2 Apr 2020 11:19:14 +0200 (CEST)
To:     Adam Goryachev <mailinglists@websitemanagers.com.au>
cc:     linux-raid@vger.kernel.org
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: RAID Issues - RAID10 working but with errors
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <d934f662-9fde-370b-bb4b-b92bd1730c96@websitemanagers.com.au>
References: <d934f662-9fde-370b-bb4b-b92bd1730c96@websitemanagers.com.au>
Comments: In-reply-to Adam Goryachev <mailinglists@websitemanagers.com.au>
   message dated "Thu, 02 Apr 2020 13:28:30 +1100."
Date:   Thu, 02 Apr 2020 11:19:14 +0200
Message-Id: <20200402091914.4330D24003E@gemini.denx.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Adam,

In message <d934f662-9fde-370b-bb4b-b92bd1730c96@websitemanagers.com.au> you wrote:
>
> smartctl -x /dev/sdd
...
> Model Family:     Western Digital RE4
> Device Model:     WDC WD2003FYYS-02W0B0
> Serial Number:    WD-WMAY00922575
...
> SMART Attributes Data Structure revision number: 16
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
>    1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    23
>    3 Spin_Up_Time            POS--K   253   253   021    -    8583
>    4 Start_Stop_Count        -O--CK   100   100   000    -    77
>    5 Reallocated_Sector_Ct   PO--CK   184   184   140    -    126
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    7 Seek_Error_Rate         -OSR-K   200   200   000    -    0
>    9 Power_On_Hours          -O--CK   017   017   000    -    61089
>   10 Spin_Retry_Count        -O--CK   100   253   000    -    0
>   11 Calibration_Retry_Count -O--CK   100   253   000    -    0
>   12 Power_Cycle_Count       -O--CK   100   100   000    -    67
> 192 Power-Off_Retract_Count -O--CK   200   200   000    -    48
> 193 Load_Cycle_Count        -O--CK   200   200   000    -    28
> 194 Temperature_Celsius     -O---K   118   105   000    -    34
> 196 Reallocated_Event_Count -O--CK   095   095   000    -    105
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 197 Current_Pending_Sector  -O--CK   200   200   000    -    21
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 198 Offline_Uncorrectable   ----CK   200   200   000    -    0
> 199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    0
> 200 Multi_Zone_Error_Rate   ---R--   200   200   000    -    2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This disk has a pretty high count of reallocated sectors, plus a lot
of other errors.  I recommend to replace it ASAP.  It is not worth
further investigation - this drive has reached EOL.


> smartctl -x /dev/sdf
...
> Model Family:     Western Digital RE4
> Device Model:     WDC WD2003FYYS-02W0B0
> Serial Number:    WD-WMAY00611922
...
> ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
>    1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    0
>    3 Spin_Up_Time            POS--K   253   253   021    -    7350
>    4 Start_Stop_Count        -O--CK   100   100   000    -    73
>    5 Reallocated_Sector_Ct   PO--CK   200   200   140    -    0
>    7 Seek_Error_Rate         -OSR-K   200   200   000    -    0
>    9 Power_On_Hours          -O--CK   051   051   000    -    36231
>   10 Spin_Retry_Count        -O--CK   100   253   000    -    0
>   11 Calibration_Retry_Count -O--CK   100   253   000    -    0
>   12 Power_Cycle_Count       -O--CK   100   100   000    -    64
> 192 Power-Off_Retract_Count -O--CK   200   200   000    -    46
> 193 Load_Cycle_Count        -O--CK   200   200   000    -    26
> 194 Temperature_Celsius     -O---K   118   094   000    -    34
> 196 Reallocated_Event_Count -O--CK   200   200   000    -    0
> 197 Current_Pending_Sector  -O--CK   200   200   000    -    0
> 198 Offline_Uncorrectable   ----CK   200   200   000    -    0
> 199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    0
> 200 Multi_Zone_Error_Rate   ---R--   200   200   000    -    2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
...
>    40 -- 51 0a 00 00 00 2a 25 4e 10 40 00  Error: UNC at LBA = 
> 0x2a254e10 = 707087888
...
>    40 -- 51 0a 00 00 00 1e 5a 3e 86 40 00  Error: UNC at LBA = 
> 0x1e5a3e86 = 509230726
...
>    40 -- 51 0a 00 00 00 1e 0c 77 d3 40 00  Error: UNC at LBA = 
> 0x1e0c77d3 = 504133587
...
>    40 -- 51 0a 00 00 00 1d e4 17 e7 40 00  Error: UNC at LBA = 
> 0x1de417e7 = 501487591
...
>    40 -- 51 0a 00 00 00 1d c0 73 99 40 00  Error: UNC at LBA = 
> 0x1dc07399 = 499151769
...
>    40 -- 51 0a 00 00 00 1d 23 fc 01 40 00  Error: UNC at LBA = 
> 0x1d23fc01 = 488897537

This disk also has stored a number of errors, but it does not look
as bad as the first one.  However, there are errors.  I would
replace it as well.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"A complex system that works is invariably found to have evolved from
a simple system that worked."             - John Gall, _Systemantics_
