Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8A1D8797
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 20:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgERSww (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 14:52:52 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:59642
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgERSww (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 18 May 2020 14:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sam-hurst.co.uk; s=20191106;
        h=content-type:in-reply-to:mime-version:date:message-id:from:references:to:
         subject:from;
        bh=um5CFTGd5SpCdohjzlCtnKpO/Wn7/UqW3ldu4uJfjEA=;
        b=HbAHd9D+rYUjdnlZMy38nvyoALOTlpphr3q57KGY3nMWjzNPpZ+KFMYvNlTDXnzBpxEyfn/SpZLdN
         Ztkb39GWZtuZO1AFqlxQQKW2jXE0LCyhEf6vJaEkyikF3dmB9bDNVlUVlbe6QYCujQsw0eNyGrEPfO
         QHgRqc/qGufxYtS9FUvazNENRKRiLIXrrT8XzhbhfjgYB/2FKroU5FZiN+HsWU7qjTxvu96aFJl390
         2oUnpl3gs/tfdmPJq0jSS/7lF+k28YM/KOSbIxwhheK//zoaTl5yWMx4vAa+rbqi2RHGJL5MOqXuaO
         oz0QXJJV80QmvqMCRhI7UGAE+avjmew==
X-HalOne-Cookie: 2fc2f08a2ee0e8c990af8156012077967d8ad487
X-HalOne-ID: c455e0b1-9938-11ea-873b-d0431ea8a290
Received: from [10.0.0.13] (82-69-64-9.dsl.in-addr.zen.co.uk [82.69.64.9])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c455e0b1-9938-11ea-873b-d0431ea8a290;
        Mon, 18 May 2020 18:52:48 +0000 (UTC)
Subject: Re: RAID wiped superblock recovery
To:     Phil Turmel <philip@turmel.org>, linux-raid@vger.kernel.org
References: <922713c5-0cc1-24cb-14a6-9de7db631f98@sam-hurst.co.uk>
 <0f954924-e7ae-c81e-55f1-afc41e293a18@turmel.org>
 <05011140-3625-5326-96c9-e995f93260f4@sam-hurst.co.uk>
 <e7644f86-5342-b7bb-b6de-b37afd74f6cc@turmel.org>
From:   Sam Hurst <sam@sam-hurst.co.uk>
Message-ID: <f88bfa57-8a17-eaa1-a926-33e2eb6ddb34@sam-hurst.co.uk>
Date:   Mon, 18 May 2020 19:52:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e7644f86-5342-b7bb-b6de-b37afd74f6cc@turmel.org>
Content-Type: multipart/mixed;
 boundary="------------4FBEEC9466DC51A2C8C4793E"
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This is a multi-part message in MIME format.
--------------4FBEEC9466DC51A2C8C4793E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Phil,

On 17/05/2020 22:56, Phil Turmel wrote:
> Your math is wrong.  Or rather, you are using the bogus power-of-ten 
> definition of "MB" that disk manufacturers use to deliver less space.
> 
> Use 128MB.  Or better, specify "262144s".

Thanks very much, that was the final thing, and now I have a working 
array again and don't have to worry about pulling 6TB of data down from S3.

I had no idea that you could use sectors as a suffix to data-offset as 
it's not in the manpage. So you should find attached a patch file which 
adds that suffix to the manpage. If this isn't the correct place to 
provide patches, or if there's an issue with the formatting of my patch, 
please let me know and I'll happily update it and send it to the correct 
place.

Best Regards,
Sam

--------------4FBEEC9466DC51A2C8C4793E
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-PATCH-Add-sector-suffix-to-mdadm-data-offset-manpage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-PATCH-Add-sector-suffix-to-mdadm-data-offset-manpage.pa";
 filename*1="tch"

From 116bc0ddeb29e848077480853a41c509518eb8ff Mon Sep 17 00:00:00 2001
From: Sam Hurst <sam@sam-hurst.co.uk>
Date: Mon, 18 May 2020 19:48:13 +0100
Subject: [PATCH] Add sector suffix to mdadm --data-offset manpage

---
 mdadm.8.in | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mdadm.8.in b/mdadm.8.in
index 9e7cb96..c997be4 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -857,8 +857,9 @@ an array which was originally created using a different version of
 which computed a different offset.
 
 Setting the offset explicitly over-rides the default.  The value given
-is in Kilobytes unless a suffix of 'K', 'M', 'G' or 'T' is used to explicitly
-indicate Kilobytes, Megabytes, Gigabytes or Terabytes respectively.
+is in Kilobytes unless a suffix of 'K', 'M', 'G', 'T' or 's' is used to
+explicitly indicate Kilobytes, Megabytes, Gigabytes, Terabytes or sectors
+respectively.
 
 Since Linux 3.4,
 .B \-\-data\-offset
-- 
2.17.1


--------------4FBEEC9466DC51A2C8C4793E--
