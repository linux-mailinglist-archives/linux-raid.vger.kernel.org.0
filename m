Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C212C4268
	for <lists+linux-raid@lfdr.de>; Wed, 25 Nov 2020 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgKYOtQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 25 Nov 2020 09:49:16 -0500
Received: from vps.thesusis.net ([34.202.238.73]:58542 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKYOtQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 25 Nov 2020 09:49:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 8AED626B16;
        Wed, 25 Nov 2020 09:49:15 -0500 (EST)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5WwmXpIwmFwl; Wed, 25 Nov 2020 09:49:15 -0500 (EST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 3652026B1A; Wed, 25 Nov 2020 09:49:15 -0500 (EST)
References: <CAB1R3sgQm2_-Bhbzned4y056XP5hM9oz1OnTZSfHH9+L5sdpFQ@mail.gmail.com>
User-agent: mu4e 1.5.6; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Alex <mysqlstudent@gmail.com>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: Considering new SATA PCIe card
In-reply-to: <CAB1R3sgQm2_-Bhbzned4y056XP5hM9oz1OnTZSfHH9+L5sdpFQ@mail.gmail.com>
Date:   Wed, 25 Nov 2020 09:49:15 -0500
Message-ID: <871rghmqz8.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Alex writes:

> RAID5 and 2x480GB SSDs in RAID1 for root. The motherboard has two
> SATA-6 ports on it and the others are SATA3.

There is no SATA-6.  There are 3 generations of SATA.  SATA-3 operates
at 6 Gbps.

