Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263C326B8E5
	for <lists+linux-raid@lfdr.de>; Wed, 16 Sep 2020 02:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgIPAvy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Sep 2020 20:51:54 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:44422 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIOLeT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 15 Sep 2020 07:34:19 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id 08FBXf6Y005735;
        Tue, 15 Sep 2020 12:33:41 +0100
From:   Nix <nix@esperi.org.uk>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     jes@trained-monkey.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 3/4] mdmonitor: set small delay once
References: <20200909083120.10396-1-mariusz.tkaczyk@intel.com>
        <20200909083120.10396-4-mariusz.tkaczyk@intel.com>
Emacs:  more than just a Lisp interpreter, a text editor as well!
Date:   Tue, 15 Sep 2020 12:33:41 +0100
In-Reply-To: <20200909083120.10396-4-mariusz.tkaczyk@intel.com> (Mariusz
        Tkaczyk's message of "Wed, 9 Sep 2020 10:31:19 +0200")
Message-ID: <87lfhbz33e.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-wuwien-Metrics: loom 1290; Body=3 Fuz1=3 Fuz2=3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9 Sep 2020, Mariusz Tkaczyk uttered the following:

> +				/*
> +				 * If mdmonitor is awaken by event, set small delay once
> +				 * to deal with udev and mdadm.
> +				 */
> +				if (wait_result != 0) {
> +					if (c->delay > 5)
> +						delay_for_event = 5;
> +				} else
> +					delay_for_event = c->delay;

This is racy: if any delay is needed, any finite delay value will
now and then be too short.

I think this should be fixed by arranging for mdmonitor to be signalled
when udev or whatever has finished whatever it's doing. (udev has lots
of ways it could be asked to do that.)
