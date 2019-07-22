Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4388C70C9C
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jul 2019 00:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbfGVWat (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 18:30:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35522 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbfGVWat (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jul 2019 18:30:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so29746033qke.2
        for <linux-raid@vger.kernel.org>; Mon, 22 Jul 2019 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwJ6+/0TysY7qDfcAsN/HYPHoTZSm1HNKXvxa4JEf7g=;
        b=M+AW4ZDpAZTUOScCykD6f3UyOwUdqQetpZ3apf/Z7Lwswco7HCwXQ4wYCqBZVxbBbG
         /u3ltZq+6RnURT533ryBQodOXFMVz2Q95eKTmVBnujo60DgPnVZqpbVk0S7077+7pvsv
         sSusBWtamwR1rBsPP3PQSbSXgH1OzINoFHj1QNpmRntq1OV7ZQcd2WVJ2Qsv78hYy0u+
         dyZNnH8RO0azuJSSgoSpCCVYsb6e3c94f/BXYBJgYWQyem8dUfzAWDhXqclvJbfG0v01
         u+mLTMtzABN0M4Ak9X8y4CIHCqsyXBM2byDoOWfbjM8C605MTApJwf2NqnzVIRNfz9fz
         1Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwJ6+/0TysY7qDfcAsN/HYPHoTZSm1HNKXvxa4JEf7g=;
        b=IZKs4OGaWsb6+qbXHdRCeDMzc3H6ZQu4KG6lhKQmAlfQ42SdcjcH1vxm/Mt6s/jQQx
         WAZB90BsdVx3LC9ikdBg3DsSmnWMY8sJjLyBTBYUaKgzAprHhNWsWcA1SOYH2c5Xh8+C
         eHDPietcupw7tM0lyVuXdNiu8F+QUq4b+IHcItA+3DlmwQA5k9fmorlLWkFa5QY8I5gD
         hmuqX0rBXqMKDQO3UeT9HgOt9AnerP6WcsQ9iQ/l0s8HrC/W5hcELC9ylg5lCqlmR1sc
         QEMy6aWptPoq2yGzPMw2zYk0rVMAZd0bhcJaUOwL1ovIN/wG5P1X4PGjzEULfJtj7O0j
         012w==
X-Gm-Message-State: APjAAAX8spdD5ac+q7yX75SvuCcR+3DBu8Q8hoc3vprBsQpliICxV9mE
        BJncBrSZ/S05a2UyjmNhokgRyUvfmtxGtfezsSY=
X-Google-Smtp-Source: APXvYqzR5GNhHzWnQ9vsBkpqh0Pd8Fl3YPKLt6bEdDUk5mNW7vy+0Ph+1zOFjCVLlU7ykvY61RBQHfAgdkZYfbpo7Ys=
X-Received: by 2002:a37:6d85:: with SMTP id i127mr47966765qkc.74.1563834648143;
 Mon, 22 Jul 2019 15:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190719054847.140905-1-yuyufen@huawei.com>
In-Reply-To: <20190719054847.140905-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 22 Jul 2019 15:30:37 -0700
Message-ID: <CAPhsuW64mgCmnBAg0Rn4ay14AGn84xAiP+Lutu2yRtSWoLRYug@mail.gmail.com>
Subject: Re: [PATCH 0/2] md: not need error handling when device faulty
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jul 18, 2019 at 10:43 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
> Hi,
>
> This patchset optimize write error handling for raid1 and raid10.
> When the device has been set faulty, error write bio did not need
> to queue for error handling by raid daemon thread.
>
>

Applied to my local branch.

Thanks,
Song
