Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE71C5211
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEEJm4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbgEEJm4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 05:42:56 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDEAC061A0F
        for <linux-raid@vger.kernel.org>; Tue,  5 May 2020 02:42:55 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jVu6I-00018M-9W; Tue, 05 May 2020 11:42:54 +0200
Subject: Re: RAID 1 | Test Booting from /dev/sdb
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <221092f3-5b8a-5d95-01d9-261e6449f747@peter-speer.de>
 <5EB12900.3030505@youngman.org.uk>
 <608e4d08-a99d-97f3-0476-3a880096f858@peter-speer.de>
 <5EB1333E.1010801@youngman.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <be57a390-734b-c215-aa59-e07c531354a0@peter-speer.de>
Date:   Tue, 5 May 2020 11:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5EB1333E.1010801@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588671775;3c6b1b84;
X-HE-SMSGID: 1jVu6I-00018M-9W
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 05.05.20 11:34, Wols Lists wrote:
> No. The journal or bitmap are stored as part of the array, not the
> filesystem. sdb will have a load of "flags" set to say "these blocks
> were written to while the array was degraded". So when sda is added back
> in, these delayed writes will be copied from sdb to sda.

When sdb copies the changes it has in the blocks /var/log sits on, will 
this result in the array showing the changes made to /var/log when it 
was booted using sdb only or did I get this wrong?
