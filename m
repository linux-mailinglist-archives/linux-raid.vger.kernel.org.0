Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6682F1ACE69
	for <lists+linux-raid@lfdr.de>; Thu, 16 Apr 2020 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgDPRJH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Apr 2020 13:09:07 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:45236 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgDPRJG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Apr 2020 13:09:06 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2020 13:09:05 EDT
Received: from [192.168.50.137] ([24.64.114.53])
        by shaw.ca with ESMTPA
        id P7sbjqUde62brP7skj8RpF; Thu, 16 Apr 2020 11:00:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shaw.ca;
        s=s20180605; t=1587056456;
        bh=8Q8AF0aei835DvFMCWRRRYWVhZtntS+GpD/VZOVUdBQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=rrIAwxMf2Mfpnih0OxXKWHfB+uEBmkUycRnkyGKF4AD1xvPzabsF77nueDhyWnvBP
         0w01tunRzBA10pxUDm+EWQfIp9XpYJ8PJQLzRvspmEveC/GlfPQln51436BzFhIi5L
         VRfz1DFq2izRSLsNQYhhsyzw1CRoL5uDsnH4Lh/86SvSOb73YZyfqB2ivm+5lijx1N
         A/rwhITiEwjT6BGnR3dplQRBmdodyOiCAsDyf/fL+F59jvFgbJkc0skb+LktpJclU6
         ol8GrK1jMVv7Ba9MBZ4LHQ8TkDcvybQ9ODvn0NYnN3/rWW1iONdprKr+jXA7P+7SZr
         Qt56rZzBQTGVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shaw.ca;
        s=s20180605; t=1587056456;
        bh=8Q8AF0aei835DvFMCWRRRYWVhZtntS+GpD/VZOVUdBQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=rrIAwxMf2Mfpnih0OxXKWHfB+uEBmkUycRnkyGKF4AD1xvPzabsF77nueDhyWnvBP
         0w01tunRzBA10pxUDm+EWQfIp9XpYJ8PJQLzRvspmEveC/GlfPQln51436BzFhIi5L
         VRfz1DFq2izRSLsNQYhhsyzw1CRoL5uDsnH4Lh/86SvSOb73YZyfqB2ivm+5lijx1N
         A/rwhITiEwjT6BGnR3dplQRBmdodyOiCAsDyf/fL+F59jvFgbJkc0skb+LktpJclU6
         ol8GrK1jMVv7Ba9MBZ4LHQ8TkDcvybQ9ODvn0NYnN3/rWW1iONdprKr+jXA7P+7SZr
         Qt56rZzBQTGVw==
X-Authority-Analysis: v=2.3 cv=LKf9vKe9 c=1 sm=1 tr=0
 a=aoFTOZhfXO3lFit9ECvAag==:117 a=aoFTOZhfXO3lFit9ECvAag==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=1WSt5VyO_ofVv4LkRygA:9
 a=QEXdDO2ut3YA:10
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Reindl Harald <h.reindl@thelounge.net>,
        Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
 <f857fc03-d18b-a489-54c9-49c22ad19c39@thelounge.net>
From:   G <garboge@shaw.ca>
Message-ID: <1142669d-1cda-b637-86d5-ddc0bee1497a@shaw.ca>
Date:   Thu, 16 Apr 2020 11:00:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <f857fc03-d18b-a489-54c9-49c22ad19c39@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfAv+ry2BPruh+mIbsv63pQeh1DSWLb6gacpvgiSnE5okv/Z6sBXiBueMct8j70z6RVwSbzqgUJ/5JSKCDMoLXmE8o4e8/p5a6Enz3+qvr4UUFQAtoUGG
 Q3tBK5Z+twNbCIOIepAD+K4VDPM6cbBEMeEfar82jo6aNdwTbRHUZlPT8+NFrpOnGyLHFBRa1OCExh7ucdwvxUm/DFFiRO1FipXwAzd7BSbQQMEBxuMhYNZL
 IzFAUcEZVX81awdAgBTU+H/NkLXJjBkX2j2Kht5F+3A=
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020-04-14 10:20 a.m., Reindl Harald wrote:
>
> Am 14.04.20 um 18:00 schrieb G:
>> Since you are running disks less than 2TB I would suggest a more
>> rudimentary setup using legacy bios booting. This setup will not allow
>> disks greater than 2TB because they would not be partitioned GPT. There
>> would still be an ability to increase total storage using more disks.
>> There would be raid redundancy with the ability for grub to boot off
>> either disk.
> terrible idea in 2020
>
> Intel announced yeas ago that they itend to remove legacy bios booting
> in 2020 and even if it#s just in 2022: RAID machines are supposed to
> live many many years and you just move the disks to your next machine
> and boot as yesterday
>
> i argued like you in 2011 and now i have a 4x2 TB RAID10 and need to
> deal with EFI-partition on a USB stick with the replacement as soon as
> there are icelake or never serious desktop machines because there is no
> single reason to reinstall from scratch when you survived already 17
> fedora dist-upgrades
>
I guess my assumptions were that in using 2TB disks this was or would be 
a relatively short-lived/limited situation possibly using an older 
motherboard. ;-)

Since the setup will be grub/UEFI on the 2TB disks what would be the 
process in upgrading to larger disks?

Thanks

