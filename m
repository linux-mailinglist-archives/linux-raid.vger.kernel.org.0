Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A482622DD2A
	for <lists+linux-raid@lfdr.de>; Sun, 26 Jul 2020 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGZIOL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Jul 2020 04:14:11 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:60471 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGZIOL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 26 Jul 2020 04:14:11 -0400
Received: from host86-157-100-178.range86-157.btcentralplus.com ([86.157.100.178] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jzbnM-000BNG-9c; Sun, 26 Jul 2020 09:14:09 +0100
Subject: Re: [PATCH v2] mdadm/Detail: show correct state for cluster-md array
To:     "heming.zhao@suse.com" <heming.zhao@suse.com>,
        linux-raid@vger.kernel.org
References: <1595401905-3459-1-git-send-email-heming.zhao@suse.com>
 <7697b7eb-76f9-8102-a490-1684e5f18acf@suse.com>
Cc:     neilb@suse.com, jes@trained-monkey.org
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5F1D3B50.8080006@youngman.org.uk>
Date:   Sun, 26 Jul 2020 09:14:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <7697b7eb-76f9-8102-a490-1684e5f18acf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 22/07/20 08:20, heming.zhao@suse.com wrote:
> During I was creating patch, I found the ExamineBitmap() has memory leak issue.
> I am not sure whether the leak issue should be fixed.
> (Because when mdadm cmd finish, all leaked memory will be released).
> The IsBitmapDirty() used some of ExamineBitmap() code, and I only fixed leaked issue in IsBitmapDirty().
> 
My gut feel?

Firstly, "do things right" - it should be fixed.
Second - are you sure this code is not run while mdadm is running as a
daemon? It's all very well saying it will be released, but but mdadm
could be running for a looonnngg time.

Cheers,
Wol

