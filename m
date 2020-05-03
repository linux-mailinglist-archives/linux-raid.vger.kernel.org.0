Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAFF1C3046
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 01:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgECXiG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 3 May 2020 19:38:06 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:31052 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgECXiG (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 3 May 2020 19:38:06 -0400
Received: from [81.153.126.158] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jVOBQ-000CbS-6J
        for linux-raid@vger.kernel.org; Mon, 04 May 2020 00:38:05 +0100
To:     Linux RAID <linux-raid@vger.kernel.org>
From:   antlists <antlists@youngman.org.uk>
Subject: WD Red drives are now SMR drives?
Message-ID: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk>
Date:   Mon, 4 May 2020 00:38:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Has anyone else picked up on this? Apparently 1TB and 8TB drives are 
still CMR, but new drives between 2 and 6 TB are now SMR drives.

https://www.extremetech.com/computing/309730-western-digital-comes-clean-shares-which-hard-drives-use-smr

What impact will this have on using them in raid arrays?

Cheers,
Wol
