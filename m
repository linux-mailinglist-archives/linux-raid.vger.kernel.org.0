Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A862A18F1B1
	for <lists+linux-raid@lfdr.de>; Mon, 23 Mar 2020 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgCWJXg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Mar 2020 05:23:36 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:48888 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgCWJXf (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 23 Mar 2020 05:23:35 -0400
Received: from [81.153.122.12] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jGJIz-0007yg-BN; Mon, 23 Mar 2020 09:23:33 +0000
Subject: Re: Raid6 recovery
To:     Phil Turmel <philip@turmel.org>,
        Glenn Greibesland <glenngreibesland@gmail.com>
References: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
 <5E75163B.2050602@youngman.org.uk>
 <CA+9eyigMV-E=FwtXDWZszSsV6JOxxFOFVh6WzmeH=OC3heMUHw@mail.gmail.com>
 <ab2a40b6-b4ab-9ff8-aef6-02d8cce8d587@youngman.org.uk>
 <CA+9eyig8U2Tzi1wF97k7eDu5vKg5Jc2sRXKaw0OCy7Cbc9HMog@mail.gmail.com>
 <c55be05d-22ee-4676-7878-5bf99ccc80f9@turmel.org>
 <CA+9eyiicKrPh9YTrGN5FjOU7zMVMqO3=8yGszWkV67fJxrtKrw@mail.gmail.com>
 <50fc13d2-bd5f-d3c3-09f6-f7274aeaf917@turmel.org>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E788014.3080203@youngman.org.uk>
Date:   Mon, 23 Mar 2020 09:23:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <50fc13d2-bd5f-d3c3-09f6-f7274aeaf917@turmel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 22/03/20 00:32, Phil Turmel wrote:
> However, there have been bugs in --force that would cause it to not
> assemble.  Also, I believe latest behavior for --re-add would not have
> damaged the metadata.

And note that the website does tell you always to use the latest version
of mdadm when trying to recover an array ... because it's linux-only
it's pretty easy to build from source if you have to.

Cheers,
Wol
