Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6295C285453
	for <lists+linux-raid@lfdr.de>; Wed,  7 Oct 2020 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJFWKg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 6 Oct 2020 18:10:36 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:47312 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgJFWKg (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 6 Oct 2020 18:10:36 -0400
Received: from host86-157-96-171.range86-157.btcentralplus.com ([86.157.96.171] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1kPvAI-000Bru-CC; Tue, 06 Oct 2020 23:10:35 +0100
Subject: Re: Need Help with Corrupted RAID6 Array
To:     Kenneth Emerson <kenneth.emerson@gmail.com>,
        linux-raid@vger.kernel.org
References: <CADzwnhXJBRuCNPsGhPHt-h1J3MU2HmH3_ZWkxW_auJ7FQyqJ0w@mail.gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <1ffdf643-9b2f-8b65-c3c1-88794d12a5e4@youngman.org.uk>
Date:   Tue, 6 Oct 2020 23:10:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CADzwnhXJBRuCNPsGhPHt-h1J3MU2HmH3_ZWkxW_auJ7FQyqJ0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 06/10/2020 12:05, Kenneth Emerson wrote:
> root@MythTV:/home/ken# mdadm --assemble --run /dev/md3
> root@MythTV:/home/ken# cat /proc/mdstat

Hope I'm not teaching grandma to suck eggs, but you have remembered to 
scatter "mdadm --stop" liberally everywhere between attempts?

Cheers,
Wol
