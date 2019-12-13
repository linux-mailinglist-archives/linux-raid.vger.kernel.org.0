Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F363C11E010
	for <lists+linux-raid@lfdr.de>; Fri, 13 Dec 2019 10:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfLMJAJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Dec 2019 04:00:09 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:38248 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMJAI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 13 Dec 2019 04:00:08 -0500
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id xBD8xp2Q005091;
        Fri, 13 Dec 2019 08:59:51 GMT
From:   Nix <nix@esperi.org.uk>
To:     Coly Li <colyli@suse.de>
Cc:     jsorensen@fb.com, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>,
        Wols Lists <antlists@youngman.org.uk>
Subject: Re: [PATCH v2] mdadm.8: add note information for raid0 growing operation
References: <20191213072934.99549-1-colyli@suse.de>
Emacs:  (setq software-quality (/ 1 number-of-authors))
Date:   Fri, 13 Dec 2019 08:59:52 +0000
In-Reply-To: <20191213072934.99549-1-colyli@suse.de> (Coly Li's message of
        "Fri, 13 Dec 2019 15:29:34 +0800")
Message-ID: <87sglobnxz.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-x.dcc-servers-Metrics: loom 104; Body=6 Fuz1=6 Fuz2=6
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13 Dec 2019, Coly Li spake thusly:
> diff --git a/mdadm.8.in b/mdadm.8.in
> index 9aec9f4..e5074c0 100644
> --- a/mdadm.8.in
> +++ b/mdadm.8.in
> @@ -2727,6 +2727,14 @@ option and it is transparent for assembly feature.
>  .IP \(bu 4
>  Roaming between Windows(R) and Linux systems for IMSM metadata is not
>  supported during grow process.
> +.IP \(bu 4
> +When growing a raid0 device, the new component disk size (or external
> +backup size) should be larger than LCM(old, new) * chunk-size * 2. Here
> +LCM stands for Least Common Multiple calculation, old and new are
> +devices' numbers before and after the grow operation, "* 2" comes from
> +the fact that mdadm refuses to use more than half of a spare device for
> +backup space. 

Hm, perhaps a slight variation, if I get this right:

When growing a raid0 device, the new component disk size (or external
backup size) should be larger than LCM(old, new) * chunk-size * 2, where
the LCM() is the least common multiple of the old and new count of
component disks, and '* 2' comes from the fact that mdadm refuses to use
more than half of a spare device for backup space.

maybe? (I'm not sure what you mean by "devices' numbers" here.)
