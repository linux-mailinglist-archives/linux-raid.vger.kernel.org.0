Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681DD1B928C
	for <lists+linux-raid@lfdr.de>; Sun, 26 Apr 2020 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZRvw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Apr 2020 13:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgDZRvw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 26 Apr 2020 13:51:52 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Apr 2020 10:51:52 PDT
Received: from resqmta-po-01v.sys.comcast.net (resqmta-po-01v.sys.comcast.net [IPv6:2001:558:fe16:19:96:114:154:160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733DC061A0F
        for <linux-raid@vger.kernel.org>; Sun, 26 Apr 2020 10:51:52 -0700 (PDT)
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-01v.sys.comcast.net with ESMTP
        id SlEfjhUHM0fBYSlP6jhZqT; Sun, 26 Apr 2020 17:49:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1587923360;
        bh=VEpz7pP426U+ovjakOsbo2ZShtZBUzj6GVRud/6/fmo=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=nDt1AZTM6kYhP8cFOF5oOslvw2Lk+kgKyCbl70D3gBA10sPCHuG4bgC27/i0SwF1p
         N2m7zxejtxmkR/wBbVK9rWsPqPq482oIWa9rbbxH3WoqQNLg7SX6pCWOJ1Om6YW27k
         E27Tuaslc1c8bkyutaPd1tvH/tOMSOUQuJ4Lbay0Zl5qaGE8i5Ql6WVWGAbwdnxyYi
         rd+SdeV1wQrEFwlf62l94Mjgexm9FI6ukrYUWeOA9IU5wQ5vi+b7GvaxMmtTZlFb7X
         Ivh+ROwTLrBX+/DK5njDFuVBHvewq9kqbTfcoHja3dtsjJ1zZiwIH9Y6xy8w/g6ruG
         RGI8kKn1HLe7Q==
Received: from [IPv6:2603:3001:600:4a00:996e:3edb:d438:f914]
 ([IPv6:2603:3001:600:4a00:996e:3edb:d438:f914])
        by resomta-po-18v.sys.comcast.net with ESMTPSA
        id SlP2jL9VhCQFrSlP6joKk4; Sun, 26 Apr 2020 17:49:20 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
To:     linux-raid@vger.kernel.org
From:   Robert Steinmetz <rob@steinmetznet.com>
Subject: Hard Drive Partition Table shows partition larger than drive
Message-ID: <6ee9392d-8867-f0b5-193e-17a516bb7e0e@steinmetznet.com>
Date:   Sun, 26 Apr 2020 13:49:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have a drive that was pulled from a Ubuntu 18.04 raid 1 and set aside. 
I am trying to se what can be done with the drive.
I installed it is a external USB enclosure and connected it to a Ubuntu 
18.04 desktop,

The Drive is a 1 TB Toshiba drive but gparted and gnome-disks give 
really odd results.

Starting gparted from a terminal I get this message:
Code:

gparted
Unit -.mount does not exist, proceeding anyway.
======================
libparted : 3.2
======================
Can't have a partition outside the disk!

Gparted reports sdb as 931.51GiB but reports partition sdb1 as 7.25 TiB.
Gparted has the following warning:
Code:

Unable to detect file system! Possible reasons are:
- The file system is damaged
- The file system is unknown to GParted
- There is no file system available (unformatted)
- The device entry /dev/sdb1 is missing

boot and raid flags are set.
Obviously something is wrong.
I originally use the drive to replace another smaller drive in a Raid 1 
array and that array was created with mdadm and maybe lvm2.
Is there a reasonable way to see if the drive has anything usable in it?

