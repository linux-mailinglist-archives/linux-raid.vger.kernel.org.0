Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0173D1B8
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391503AbfFKQHN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 12:07:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39959 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391474AbfFKQHN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 12:07:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so15178508qtn.7
        for <linux-raid@vger.kernel.org>; Tue, 11 Jun 2019 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WziNz0OW7u3Zvis6qv1bj6OykH5fklJgkQ1QvvWUKrw=;
        b=CuJFCc1hM5ZX40L0TPUOrsqAoYImaKQwIwVuKijkqtIAGc9ovKS82KgKZ2G1uoPhBC
         myizHfm8dNMSigFSeEpg3T1YNhGIPCBHYtSpQOZHo9kFQ8qByseBDTDfkgaZINboXNCP
         MBct+gpEZStPwk8R54qliAmRLqUIxEqZD69xcPKqek/+7y9FofFHeoYoxUVrwgEhvGLx
         F6yxqRIY9sP4KmopxujT6m9kNrHjdIl8tueG6RBltm/RYzaZlcDsLz1S8VSppLXbZ8Yl
         3shbAl7f88xRuFCh+vgtUbykwXAdYGqWZxuOkgQ88yEWqArKdlG37uDScIKRAb984j7I
         dR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WziNz0OW7u3Zvis6qv1bj6OykH5fklJgkQ1QvvWUKrw=;
        b=K3VDmfH0DysWoXRBbDr1fJwMOmXb1geDqtTfacrJpKiqQW7RosHZiq42SIjgzo9Ijy
         oJff5DN0M9iHxKT+mL91zjD/bhDRRHK1m18OHJouXwkS0vOwR5PVcI+HRHiJ+AeGRJku
         PMzhKrptQMRO4dZdQXgqQM6TvSb0rcZ3kIxXmkfPYgTXnQAIwEusvUDibYCWbv3Ce5X/
         TzUr5RNQUjlXI3B04kco92IPGUHOAcCgmCjja6xwS90g1i8cBo4q+iwd+PmkaEeUV/24
         UDJQ+B1zL+UQzrnSAZkVoa2/VeZtS2N3b3zvdpRTInX4jKrMH7e/hR2mYLOwkYPkTsJ+
         JGjg==
X-Gm-Message-State: APjAAAVFaUg/lFstlIy1c6hlagkP1BJCftrwIfy2OQzCWBmNDv+szmbU
        uzh8ttF6EXwCoHR5sslYach8GPrVwgI7q1NkXAY=
X-Google-Smtp-Source: APXvYqzh8QTP1oJ6QknND5xaS7YlMF9Z85DIe/8ZvcEjLRBNIZjsFUVQ7ANeGDNRuKGMYx0eSrr/q0DSF1Hfm0nHFIA=
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr53351796qtf.139.1560269232357;
 Tue, 11 Jun 2019 09:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190611073311.14120-1-gqjiang@suse.com> <20190611074315.GA28052@www5.open-std.org>
 <1110737b-e037-9ef8-395e-83bd540e24b1@suse.com> <20190611143929.GA13825@www5.open-std.org>
In-Reply-To: <20190611143929.GA13825@www5.open-std.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 11 Jun 2019 09:07:01 -0700
Message-ID: <CAPhsuW4E4tdaOEMFbH4TmN_P3xSAZqdgcq3G=8sUF4jjXX87mg@mail.gmail.com>
Subject: Re: [PATCH] md/raid10: read balance chooses idlest disk for SSD
To:     keld@keldix.com
Cc:     Guoqing Jiang <gqjiang@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 11, 2019 at 7:40 AM <keld@keldix.com> wrote:
>
> On Tue, Jun 11, 2019 at 04:11:52PM +0800, Guoqing Jiang wrote:
> > Hi,
> >
> > On 6/11/19 3:43 PM, keld@keldix.com wrote:
> > >thanks for this patch
> > >
> > >I think we should change the hd algorithm to chose the highest block
> > >number at least for the
> > >far layout. ther outer blocks have the fastest transfer rates and also the
> > >shortest
> > >distance for head movement.
> >
> > I didn't investigate the performance of far layout a lot, seems there
> > was one patch
> > (commit 8ed3a19563b6c " md: don't attempt read-balancing for raid10
> > 'far' layouts")
> > which was aimed to do it, and you were the author, no? ;-). Or I missed
> > something.
>
> yes , I was the author of that patch.
> and it solved the problem: to get the drives to stripe, evne if the hd drives
> have different transfer rates and rotation speeds.
>
> what I think I got wrong was that it was using the inner parts of the disks
> instead of the outer parts, where the transfer rate is higer and head movement less.

IIUC, the patch prefers using smaller LBA ranges, no? And smaller LBA
means outer sectors, no?

Thanks,
Song


>
> I am suggesting now to reverse this.
>
> keld
