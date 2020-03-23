Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A813718F4B7
	for <lists+linux-raid@lfdr.de>; Mon, 23 Mar 2020 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgCWMfg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Mar 2020 08:35:36 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39311 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgCWMfd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Mar 2020 08:35:33 -0400
Received: by mail-lj1-f182.google.com with SMTP id i20so2263752ljn.6
        for <linux-raid@vger.kernel.org>; Mon, 23 Mar 2020 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nhox2YnQgWEWO5xdJgwWjiBZX8/Bd+KUuTcLtwuhQ8A=;
        b=hBlLq3TfCOf2SkrOhuHojp3wNnNiZoqcrwJUSSufN+X3gqepub2/UtcpwF2Od30pl5
         QpPRRp4yptWmfbSWfdborIpGY84mhSmbp3veP5ceVIAm8hDcWSUih7Q3saVHitVLQ4bQ
         jHyNKaeuHFVeyyPR+B5dYd2zIOOkYBZq7gP9r+xuobalclL43J+Bv4DyiAqG2f31JUc+
         fro+bLrwPAX27HjWf+kluiQECW+yAS/JuTCC6p6pFeZaS160SGWq64i8BTC+8xlhVnEG
         QaNllbXSPiqUelYi/73ZMQ/DCSuSyWEkioqGCBOjnvTKqE+EiG2aXsrgmFVu/OuxvPj0
         fzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nhox2YnQgWEWO5xdJgwWjiBZX8/Bd+KUuTcLtwuhQ8A=;
        b=RzM9tETg0muBqnH3o/gSpbXmN2SW9O1JGIVXcIawUxXRrJVXjPjEJP2egg8Kwq62yS
         0/VjeCkHgDv8cGyhxyHFi/Zkm/rcz8rNV+QKGjHT8BoT2zbpReMYofNjqKKEDlzL6W9+
         7dhumLMtpw6nlA4+IJ77a99xZ5hIp/9hXnyS8bZKlqlyFFUfaJJPgC4U3//a6aEnQwAB
         UKii4yk4gm5o2eveKEKXpNwqaDb8ekaVKebcr1Olo7kfnibGRJvJ1BaJE9fj5/JsnHma
         Kp+XA0xGy9wrpZ0eQZGJbjvIfxjQ6VUWlMGSinOpfbpjqd8sFfr+uuShgLA35MInPD+f
         u3Qg==
X-Gm-Message-State: ANhLgQ18w4Pr2NVbcBRJ9Mgjy0QB+VMK0DZuPXyJywdp1/jYKAEHhPbk
        KzZKWdSSK8pwmWaFyCPxJzRaPPxmiMRsyGs6Jx8=
X-Google-Smtp-Source: ADFU+vsiP1bqrxBK/sorUMCWY1umtDcWdnzk1AAg9/kwpUxXWVPQ15dbLFsNmrsjnyRUGVAsPgN0ERAXqQyfaktZVHM=
X-Received: by 2002:a2e:92d6:: with SMTP id k22mr13865508ljh.18.1584966930912;
 Mon, 23 Mar 2020 05:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
 <5E75163B.2050602@youngman.org.uk> <CA+9eyigMV-E=FwtXDWZszSsV6JOxxFOFVh6WzmeH=OC3heMUHw@mail.gmail.com>
 <ab2a40b6-b4ab-9ff8-aef6-02d8cce8d587@youngman.org.uk> <CA+9eyig8U2Tzi1wF97k7eDu5vKg5Jc2sRXKaw0OCy7Cbc9HMog@mail.gmail.com>
 <c55be05d-22ee-4676-7878-5bf99ccc80f9@turmel.org> <CA+9eyiicKrPh9YTrGN5FjOU7zMVMqO3=8yGszWkV67fJxrtKrw@mail.gmail.com>
 <50fc13d2-bd5f-d3c3-09f6-f7274aeaf917@turmel.org> <5E788014.3080203@youngman.org.uk>
In-Reply-To: <5E788014.3080203@youngman.org.uk>
From:   Glenn Greibesland <glenngreibesland@gmail.com>
Date:   Mon, 23 Mar 2020 13:35:19 +0100
Message-ID: <CA+9eyihM0pAZXY4MwqDr3FSD7FAp+3oFFU4-7U3n7MVSKi+o7A@mail.gmail.com>
Subject: Re: Raid6 recovery
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Phil Turmel <philip@turmel.org>, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

man. 23. mar. 2020 kl. 10:23 skrev Wols Lists <antlists@youngman.org.uk>:

> And note that the website does tell you always to use the latest version
> of mdadm when trying to recover an array ... because it's linux-only
> it's pretty easy to build from source if you have to.

I was probably using verison 3.3-2 when I ran --re-add and the problem
started. That is the latest version available for the verison of
Ubuntu Server I am running.
I then upgraded to v4.0 and later to v4.1-65 by building from source.
Lesson learned.

Question about mdadm documentation:
Should the man page be updated to reflect the support for using
sectors as units in addition to K M G and T?

Glenn
