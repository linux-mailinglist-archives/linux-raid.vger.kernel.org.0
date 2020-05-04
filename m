Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF16D1C3E42
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgEDPPy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728684AbgEDPPy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 11:15:54 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46AC061A0E
        for <linux-raid@vger.kernel.org>; Mon,  4 May 2020 08:15:53 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jVcox-0003aT-RD; Mon, 04 May 2020 17:15:51 +0200
Subject: Re: RAID 1 | Restore based on Image of /dev/sda
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
To:     Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
References: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
 <838c9c29-4256-40e1-8c49-12eba590b749@thelounge.net>
 <506dd960-0e90-d146-1598-6d3ee8bd5798@peter-speer.de>
Message-ID: <5e5f75fa-2ace-51e4-21c8-1f0860fc30df@peter-speer.de>
Date:   Mon, 4 May 2020 17:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <506dd960-0e90-d146-1598-6d3ee8bd5798@peter-speer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588605354;e70d136f;
X-HE-SMSGID: 1jVcox-0003aT-RD
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 04.05.20 13:13, Stefanie Leisestreichler wrote:
> 
> 
> On 04.05.20 12:59, Reindl Harald wrote:
>> mdadm /dev/mdX --add /dev/sdx{1,2}
> 
> Thanks, Harald.
> Will do it like you suggested.

Array is recoverd and [UU] again.
Thanks again.
